const assert = require("assert");
const firebase = require("@firebase/testing");
// Firebase project ID
const TEST_PROJECT_ID = "philov-withcenter";

const A = "user_A";
const B = "user_B";
const C = "user_C";
const authA = { uid: A, email: A + "@gmail.com" };
const authB = { uid: B, email: B + "@gmail.com" };
const authC = { uid: C, email: C + "@gmail.com" };

// Get Firestore DB connection with user auth
function db(auth = null) {
  return firebase
    .initializeTestApp({ projectId: TEST_PROJECT_ID, auth: auth })
    .firestore();
}

// Get Firestore DB connection with admin auth
// Note, if you are logged in as admin, it will pass the security check.
function admin() {
  return firebase
    .initializeAdminApp({ projectId: TEST_PROJECT_ID })
    .firestore();
}

async function getUser(uid) {
  const snapshot = await admin().collection("users").doc(uid).get();
  return snapshot.data();
}
async function setUser(uid, data) {
  return await admin().collection("users").doc(uid).set(data, { merge: true });
}

async function setCategory(id, data) {
  return admin().collection("categories").doc(id).set(data, { merge: true });
}

/**
 * 글을 생성하고, id 와 함께 문서를 리턴
 *
 * - data.category 에 해당하는 카테고리를 생성.
 * - 글 생성(문서 추가)
 * - 생성된(추가된 글) 문서에 id 를 추가하여 리턴.
 *
 *
 * @param {*} data 게시판 글 생성할 데이터
 * @returns 생성된 문서와 id
 */
async function createPost(data) {
  await setCategory(data.category, { title: data.category });
  const ref = await admin().collection("posts").add(data);

  const snapshot = await ref.get();
  const ret = snapshot.data();
  ret.id = snapshot.id;
  return ret;
}

/// Create chat room with users
async function createChatRoom(users) {
  const ref = await admin()
    .collection("chat_rooms")
    .add({
      users: users.map((e) => db().collection("users").doc(e)),
    });

  const snapshot = await ref.get();
  return snapshot;
}

// Clear all data before each test
beforeEach(async () => {
  await firebase.clearFirestoreData({ projectId: TEST_PROJECT_ID });
});

describe("Firestore security test", () => {
  it("Chat room read", async () => {
    const snapshot = await createChatRoom([A]);

    const bToBeFailed = db(authB).collection("chat_rooms").doc(snapshot.id);
    await firebase.assertFails(bToBeFailed.get());

    const aToBeSucceed = db(authA).collection("chat_rooms").doc(snapshot.id);
    await firebase.assertSucceeds(aToBeSucceed.get());
  });

  it("Chat room update - expect failure", async () => {
    const snapshot = await createChatRoom([A]);
    await firebase.assertFails(
      db(authB).collection("chat_rooms").doc(snapshot.id).update({
        lastMessage: "Hello",
      })
    );
  });
  it("Chat room update - expect success", async () => {
    const snapshot = await createChatRoom([A, C]);
    // console.log(snapshot.data().users.map((e) => e.id));
    await firebase.assertSucceeds(
      db(authA).collection("chat_rooms").doc(snapshot.id).update({
        lastMessage: "Hello",
      })
    );
  });
  it("Chat room create and create message", async () => {
    const snapshot = await createChatRoom([A, C]);

    await firebase.assertSucceeds(
      db(authA)
        .collection("chat_room_messages")
        .add({
          chatRoomDocumentReference: snapshot.ref,
          userDocumentReference: db().collection("users").doc(A),
          text: "text",
        })
    );

    await firebase.assertFails(
      db(authB)
        .collection("chat_room_messages")
        .add({
          chatRoomDocumentReference: snapshot.ref,
          userDocumentReference: db().collection("users").doc(B),
          text: "text",
        })
    );

    await firebase.assertSucceeds(
      db(authC)
        .collection("chat_room_messages")
        .add({
          chatRoomDocumentReference: snapshot.ref,
          userDocumentReference: db().collection("users").doc(C),
          text: "text",
        })
    );
  });

  it("Chat room create and read message", async () => {
    const snapshot = await createChatRoom([A, C]);

    await firebase.assertSucceeds(
      db(authA)
        .collection("chat_room_messages")
        .add({
          chatRoomDocumentReference: snapshot.ref,
          userDocumentReference: db().collection("users").doc(A),
          text: "text",
        })
    );
    const size = (
      await db(authA)
        .collection("chat_room_messages")
        .where("chatRoomDocumentReference", "==", snapshot.ref)
        .get()
    ).size;
    assert(size === 1);

    await firebase.assertFails(
      db(authB)
        .collection("chat_room_messages")
        .where("chatRoomDocumentReference", "==", snapshot.ref)
        .get()
    );

    await firebase.assertSucceeds(
      db(authC)
        .collection("chat_room_messages")
        .where("chatRoomDocumentReference", "==", snapshot.ref)
        .get()
    );
  });
});
