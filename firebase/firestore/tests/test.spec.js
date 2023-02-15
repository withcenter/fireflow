const assert = require("assert");
const firebase = require("@firebase/testing");
// Firebase project ID
const TEST_PROJECT_ID = "withcenter-fireflow";

const A = "user_A";
const B = "user_B";
const C = "user_C";
const D = "user_D";
const authA = { uid: A, email: A + "@gmail.com" };
const authB = { uid: B, email: B + "@gmail.com" };
const authC = { uid: C, email: C + "@gmail.com" };
const authD = { uid: D, email: D + "@gmail.com" };

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

// Get user document reference with the user permission.
function userDoc(id) {
  return db({ uid: id, email: id + "@gmail.com" })
    .collection("users")
    .doc(id);
}
function ref(id) {
  return userDoc(id);
}

/**
 * Return user data
 * @param {*} uid user uid
 * @returns snapshot data
 */
async function getUser(uid) {
  const snapshot = await admin().collection("users").doc(uid).get();
  return snapshot.data();
}
async function setUser(uid, data) {
  return await admin().collection("users").doc(uid).set(data, { merge: true });
}

/**
 * Creates or updates a category.
 *
 * @param {*} id category id
 * @param {*} data category like. ex) { title: "category title" }
 * @returns Promise<void>
 */
async function setCategory(id, data = {}) {
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
      userDocumentReferences: users.map((e) => userDoc(e)),
      unsubscribedUserDocumentReferences: [],
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
  it("Chat room list", async () => {
    let snapshot = await createChatRoom([A, C]);
    // const adminList = await admin()
    //   .collection("chat_rooms")
    //   .where("usersDocumentReferences", "array-contains", [userDoc(B)])
    //   .get();

    const list = db(authB)
      .collection("chat_rooms")
      .where("userDocumentReferences", "array-contains", userDoc(B))
      .get();

    await firebase.assertSucceeds(list);
    snapshot = await list;
    assert(snapshot.size === 0);

    //
    const listA = db(authA)
      .collection("chat_rooms")
      .where("userDocumentReferences", "array-contains", userDoc(A))
      .get();

    await firebase.assertSucceeds(listA);
    const snapshotA = await listA;
    assert(snapshotA.size === 1);

    //
    const listN = db()
      .collection("chat_rooms")
      .where("userDocumentReferences", "array-contains", userDoc(A))
      .get();

    await firebase.assertFails(listN);
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

  it("Chat room collection query - by moderator", async () => {
    const snapshot = await createChatRoom([A, C]);

    await snapshot.ref.update({
      moderatorUserDocumentReferences: [userDoc(B)],
    });

    const snapshotUp = await snapshot.ref.get();

    const id = snapshotUp.data().moderatorUserDocumentReferences[0].id;
    assert(id === B);

    const querySnapshot = await db(authB)
      .collection("chat_rooms")
      .where("moderatorUserDocumentReferences", "array-contains", userDoc(B))
      .get();
    // console.log(querySnapshot.docs);
    assert(querySnapshot.size === 1);
  });
  it("Chat message edit", async () => {
    const snapshot = await createChatRoom([A, C]);

    const ref = await db(authA)
      .collection("chat_room_messages")
      .add({
        chatRoomDocumentReference: snapshot.ref,
        userDocumentReference: db().collection("users").doc(A),
        text: "text",
      });

    const messageDoc = await ref.get();

    await firebase.assertFails(
      db(authB)
        .collection("chat_room_messages")
        .doc(messageDoc.id)
        .update({ text: "up" })
    );
    await firebase.assertFails(
      db(authC)
        .collection("chat_room_messages")
        .doc(messageDoc.id)
        .update({ text: "up" })
    );
    await firebase.assertSucceeds(
      db(authA)
        .collection("chat_room_messages")
        .doc(messageDoc.id)
        .update({ text: "up" })
    );
  });
  it("Chat message delete", async () => {
    const snapshot = await createChatRoom([A, C]);

    const ref = await db(authA)
      .collection("chat_room_messages")
      .add({
        chatRoomDocumentReference: snapshot.ref,
        userDocumentReference: db().collection("users").doc(A),
        text: "text",
      });

    const messageDoc = await ref.get();

    await firebase.assertFails(
      db(authB).collection("chat_room_messages").doc(messageDoc.id).delete()
    );
    await firebase.assertFails(
      db(authC).collection("chat_room_messages").doc(messageDoc.id).delete()
    );
    await firebase.assertSucceeds(
      db(authA).collection("chat_room_messages").doc(messageDoc.id).delete()
    );
  });

  it("Subscribe", async () => {
    let snapshot = await createChatRoom([A, B, C]);
    let ref = snapshot.ref;
    let data = snapshot.data();
    assert(data.unsubscribedUserDocumentReferences.length === 0);

    // [] -> [ A ]
    await firebase.assertSucceeds(
      db(authA)
        .collection("chat_rooms")
        .doc(snapshot.id)
        .update({
          unsubscribedUserDocumentReferences:
            firebase.firestore.FieldValue.arrayUnion(userDoc(A)),
        })
    );

    snapshot = await ref.get();
    assert(snapshot.data().unsubscribedUserDocumentReferences.length === 1);
    assert(
      snapshot.data().unsubscribedUserDocumentReferences[0].id === userDoc(A).id
    );

    // [ A ] -> [ ]
    await firebase.assertSucceeds(
      db(authA)
        .collection("chat_rooms")
        .doc(snapshot.id)
        .update({
          unsubscribedUserDocumentReferences:
            firebase.firestore.FieldValue.arrayRemove(userDoc(A)),
        })
    );

    snapshot = await ref.get();
    assert(snapshot.data().unsubscribedUserDocumentReferences.length === 0);

    /// [ A, B, C, D ]
    await admin()
      .collection("chat_rooms")
      .doc(snapshot.id)
      .update({
        unsubscribedUserDocumentReferences: [
          userDoc(A),
          userDoc(B),
          userDoc(C),
          userDoc(D),
        ],
      });

    snapshot = await ref.get();
    assert(snapshot.data().unsubscribedUserDocumentReferences.length === 4);
    assert(
      snapshot.data().unsubscribedUserDocumentReferences[0].id === userDoc(A).id
    );
    assert(
      snapshot.data().unsubscribedUserDocumentReferences[1].id === userDoc(B).id
    );
    assert(
      snapshot.data().unsubscribedUserDocumentReferences[2].id === userDoc(C).id
    );
    assert(
      snapshot.data().unsubscribedUserDocumentReferences[3].id === userDoc(D).id
    );

    // Failure. It is not allowed to remove other users.
    //
    // It is trying: [ A, B, C, D ] -> [ A, B, C ]
    await firebase.assertFails(
      db(authA)
        .collection("chat_rooms")
        .doc(snapshot.id)
        .update({
          unsubscribedUserDocumentReferences:
            firebase.firestore.FieldValue.arrayRemove(userDoc(D)),
        })
    );
    // [ A, B, C, D] -> [ B, C, D ]
    await firebase.assertSucceeds(
      db(authA)
        .collection("chat_rooms")
        .doc(snapshot.id)
        .update({
          unsubscribedUserDocumentReferences:
            firebase.firestore.FieldValue.arrayRemove(userDoc(A)),
        })
    );

    snapshot = await ref.get();
    assert(snapshot.data().unsubscribedUserDocumentReferences.length === 3);
    assert(
      snapshot.data().unsubscribedUserDocumentReferences[0].id === userDoc(B).id
    );
    assert(
      snapshot.data().unsubscribedUserDocumentReferences[1].id === userDoc(C).id
    );
    assert(
      snapshot.data().unsubscribedUserDocumentReferences[2].id === userDoc(D).id
    );

    // Trying to remove a user ref that is not in the array. So, the update action does not happen.
    //
    // [ B, C, D ] -> [ B, C, D ]
    await firebase.assertSucceeds(
      db(authB)
        .collection("chat_rooms")
        .doc(snapshot.id)
        .update({
          unsubscribedUserDocumentReferences:
            firebase.firestore.FieldValue.arrayRemove(userDoc(A)),
        })
    );

    // [ B, C, D ] -> [ C, D ]
    await firebase.assertSucceeds(
      db(authB)
        .collection("chat_rooms")
        .doc(snapshot.id)
        .update({
          unsubscribedUserDocumentReferences:
            firebase.firestore.FieldValue.arrayRemove(userDoc(B)),
        })
    );

    snapshot = await ref.get();
    assert(snapshot.data().unsubscribedUserDocumentReferences.length === 2);
    assert(
      snapshot.data().unsubscribedUserDocumentReferences[0].id === userDoc(C).id
    );
    assert(
      snapshot.data().unsubscribedUserDocumentReferences[1].id === userDoc(D).id
    );

    // It is not allowed to add other user's ref.
    //
    // It is try to: [ C, D ] -> [ C, D, A ]
    await firebase.assertFails(
      db(authC)
        .collection("chat_rooms")
        .doc(snapshot.id)
        .update({
          unsubscribedUserDocumentReferences:
            firebase.firestore.FieldValue.arrayUnion(userDoc(A)),
        })
    );
  });

  it("Failure on creating a post with non-existing category.", async () => {
    await firebase.assertFails(
      db(authA)
        .collection("posts")
        .add({ category: "non-existsing", title: "title" })
    );
  });
  it("Success on creating a post with existing category, but without my ref.", async () => {
    await setCategory("apple");
    await firebase.assertFails(
      db(authA).collection("posts").add({ category: "apple", title: "title" })
    );
  });
  it("Success on creating a post with existing category.", async () => {
    await setCategory("apple");
    await firebase.assertSucceeds(
      db(authA)
        .collection("posts")
        .add({
          category: "apple",
          userDocumentReference: ref(A),
          title: "title",
        })
    );
  });

  it("Push notifications", async () => {
    /// wrong data
    await firebase.assertFails(
      db(authA).collection("users").doc(A).collection("fcm_tokens").add({
        a: "b",
      })
    );

    /// missing info
    await firebase.assertFails(
      db(authA).collection("users").doc(A).collection("fcm_tokens").add({
        fcm_token: "...",
      })
    );
    /// missing info
    await firebase.assertFails(
      db(authA).collection("users").doc(A).collection("fcm_tokens").add({
        fcm_token: "...",
        device_type: "ios",
      })
    );
    /// create - ok
    const added = db(authA)
      .collection("users")
      .doc(A)
      .collection("fcm_tokens")
      .add({
        fcm_token: "...",
        device_type: "ios",
        created_at: firebase.firestore.FieldValue.serverTimestamp(),
      });
    await firebase.assertSucceeds(added);

    /// update - ok
    await firebase.assertSucceeds((await added).update({ fcm_token: "yo" }));

    /// wrong permission - create
    await firebase.assertFails(
      db(authA).collection("users").doc(B).collection("fcm_tokens").add({
        fcm_token: "...",
        device_type: "ios",
        created_at: firebase.firestore.FieldValue.serverTimestamp(),
      })
    );

    /// wrong permission - update
    await firebase.assertFails(
      db(authB)
        .collection("users")
        .doc(A)
        .collection("fcm_tokens")
        .doc((await added).id)
        .update({
          fcm_token: "...update...",
          device_type: "ios",
          created_at: firebase.firestore.FieldValue.serverTimestamp(),
        })
    );
    /// wrong permission - delete
    await firebase.assertFails(
      db(authB)
        .collection("users")
        .doc(A)
        .collection("fcm_tokens")
        .doc((await added).id)
        .delete()
    );

    /// delete - ok
    await firebase.assertSucceeds(
      db(authA)
        .collection("users")
        .doc(A)
        .collection("fcm_tokens")
        .doc((await added).id)
        .delete()
    );
  });
});
