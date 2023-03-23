import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:fireflow/fireflow.dart';
import 'package:fireflow/src/backend/backend.dart';
import 'package:path/path.dart' as p;
import 'package:rxdart/subjects.dart';

/// UserService is a singleton class that provides necessary service for user
/// related features.
///
class UserService {
  // create a singleton method of UserService
  UserService._() {
    dog("UserService._() called. It should be called only once.");
  }
  static UserService get instance => _instance ?? (_instance = UserService._());
  static UserService? _instance;

  fa.FirebaseAuth get auth => fa.FirebaseAuth.instance;

  /// The Firebase Firestore instance
  FirebaseFirestore db = FirebaseFirestore.instance;

  /// The collection reference of the users collection
  CollectionReference get col => db.collection('users');

  /// Returns a document reference of the given id.
  DocumentReference doc(String id) => col.doc(id);

  /// The login user's uid
  String get uid => auth.currentUser!.uid;

  /// The login user's document reference
  DocumentReference get ref =>
      FirebaseFirestore.instance.collection('users').doc(uid);

  DocumentReference get myRef => ref;

  CollectionReference get publicDataCol => db.collection('users_public_data');

  /// The login user's public data document reference
  DocumentReference get myUserPublicDataRef =>
      FirebaseFirestore.instance.collection('users_public_data').doc(uid);

  DocumentReference get publicRef => myUserPublicDataRef;

  /// The login user's Firebase User object.
  fa.User get currentUser => auth.currentUser!;

  /// Returns true if the user is logged in.
  bool get isLoggedIn => auth.currentUser != null;
  bool get notLoggedIn => !isLoggedIn;

  /// The login user's public data document stream.
  StreamSubscription? publicDataSubscription;

  /// The login user's public data document stream.
  StreamSubscription? mySubscription;

  /// The login user's data model.
  ///
  /// It is updated (synced) on /users/<uid> document changes.
  UsersRecord? _my;
  UsersRecord get my => _my!;
  set my(UsersRecord? v) => _my = v;

  /// The login user's public data model.
  ///
  /// It listens the changes of the user's public data document and update [my] variable.
  /// Note that, this is always upto date. So, you don't have to get the login user's
  /// public data document from the firestore.
  UsersPublicDataRecord? _pub;
  UsersPublicDataRecord get pub => _pub!;
  set pub(UsersPublicDataRecord? value) => _pub = value;

  ///

  final BehaviorSubject<UsersRecord?> onMyChange =
      BehaviorSubject<UsersRecord?>.seeded(null);
  final BehaviorSubject<UsersPublicDataRecord?> onPubChange =
      BehaviorSubject<UsersPublicDataRecord?>.seeded(null);

  reset() {
    my = null;
    pub = null;
    onMyChange.add(_my);
    onPubChange.add(_pub);
  }

  /// Check if pub doc exists
  ///
  /// return true if user's public data document exists
  userPublicDataDocumentExists() async {
    final doc = await myUserPublicDataRef.get();
    return doc.exists;
  }

  /// Warning, this method may throw an exception if it is being called immediately after the user is signed in for the first time.
  /// The `/users/{uid}` document may be created after the user is signed in.
  Future<UserModel> getUser() async {
    // get the user's data from the database
    final snapshot = await ref.get();
    return UserModel.fromSnapshot(snapshot);
  }

  /// Returns the user's public data model.
  ///
  /// [id] is the other user uid. If it is set, it returns other user pubic data model.
  Future<UserPublicDataModel?> getPublicData([String? id]) async {
    // get the user's public data from the database
    DocumentSnapshot snapshot;
    if (id == null) {
      snapshot = await myUserPublicDataRef.get();
    } else {
      snapshot = await publicDataCol.doc(id).get();
    }
    if (snapshot.exists == false) {
      return null;
    }
    return UserPublicDataModel.fromSnapshot(snapshot);
  }

  /// Get user document by uid.
  ///
  /// Note, it returns user data model. Not the user's public data.
  Future<UsersRecord> get([String? id]) {
    return UsersRecord.getDocumentOnce(doc(id ?? uid));
  }

  // Future<UserModel> get([String? id]) async {
  //   return UserModel.fromSnapshot(await doc(id ?? uid).get());
  // }

  /// /users 컬렉션 생성
  ///
  /// FF 에서는 회원 가입 후, 바로 이런 코드를 호출하여 /users 컬렉션을 생성하지만,
  /// FF 를 쓰지 않는 경우, 또는 그 외의 예외적인 경우에서, /users 문서가 생성되지 않았을 경 대비, 성성한다.
  ///
  /// AppService 에서 한번만 호출됨.
  Future maybeGenerateUserDocument() async {
    await maybeCreateUser(FirebaseAuth.instance.currentUser!);
  }

  /// /users_public_data 컬렉션 생성 및 관리
  ///
  /// Creates /users_public_data/{uid} on registration or if it does not exist by any chance.
  ///
  /// This will crate /users_public_data/{uid} only if the user is logged in for the first time.
  ///
  /// AppService 에서 한번만 호출됨.
  Future maybeGenerateUserPublicDataDocument() async {
    ///
    if (await userPublicDataDocumentExists() == false) {
      /// Generate the user's public data document
      ///
      final data = createUsersPublicDataRecordData(
        displayName: currentUser.displayName ?? '',
        photoUrl: currentUser.photoURL ?? '',
        uid: uid,
        userDocumentReference: ref,
      );
      data['registeredAt'] = FieldValue.serverTimestamp();
      await myUserPublicDataRef.set(data);
    }

    /// Update the default uid and reference information
    ///
    /// To make sure that the user's public data document reference always
    /// exists in /users/{uid}, it updates on every boot.
    ///
    /// Somehow, in some case (probably in test environment), it really
    /// happened that the uid and references are not properly set and
    /// produced an error.
    ///
    /// If the user's public data document has no uid and reference, it
    /// will cause
    await myUserPublicDataRef.set(
      {
        'uid': uid,
        'userDocumentReference': ref,
      },
      SetOptions(
        merge: true,
      ),
    );

    /// 사용자 문서에 /users_public_data 문서 참조 저장.
    await myRef.set({
      'userPublicDataDocumentReference': myUserPublicDataRef,
    }, SetOptions(merge: true));

    dog("UserService.generateUserPublicData() - user public data generated at ${myUserPublicDataRef.path}");
  }

  /// Listen and sync the user model.
  listenUserDocument() {
    /// Observe the user data.
    mySubscription?.cancel();
    mySubscription = ref.snapshots().listen((snapshot) {
      if (snapshot.exists) {
        my = UsersRecord.getDocumentFromData(
            snapshot.data() as Map<String, dynamic>, snapshot.reference);
        onMyChange.add(my);
      }
    });
  }

  /// Listen the changes of users_public_data/{uid}.
  ///
  /// It listens the update of the login user's public data document and
  /// - keep the user's public data in memory.
  /// - update the user's public data into Supabase if neccessary.
  listenUserPublicDataDocument() {
    /// Observe the user public data.
    publicDataSubscription?.cancel();
    publicDataSubscription = UserService.instance.myUserPublicDataRef
        .snapshots()
        .listen((snapshot) async {
      if (snapshot.exists) {
        // pub = UserPublicDataModel.fromSnapshot(snapshot);
        pub = UsersPublicDataRecord.getDocumentFromData(
            snapshot.data() as Map<String, dynamic>, snapshot.reference);

        /// Update user profile completion status
        ///
        /// TODO: Let's developer add more fields to check the profile completion. For instance, "displayName,photoUrl,gender,birthday"
        await publicRef.set({
          'isProfileComplete':
              pub.displayName!.isNotEmpty && pub.photoUrl!.isNotEmpty,
        }, SetOptions(merge: true));

        onPubChange.add(pub);
        if (SupabaseService.instance.storeUsersPubicData) {
          /// Upsert the user public data to Supabase.
          final data = {
            'uid': pub.uid,
            'display_name': pub.displayName,
            'photo_url': pub.photoUrl,
            'gender': pub.gender,
            'birthday': pub.birthday?.toIso8601String(),
            'registered_at': pub.registeredAt?.toIso8601String(),
          };

          dog('Supabase upsert: $data');
          await supabase.usersPublicData.upsert(
            data,
            onConflict: 'uid',
          );
        }
      }
    });
  }

  /// Updates the user's public data with the given imagePath
  afterProfilePhotoUpload(String? imagePath) async {
    return await afterUserPhotoUpload(
      'photoUrl',
      imagePath,
    );
  }

  /// Updates the user's public data with the given imagePath
  Future<void> afterCoverPhotoUpload(String? imagePath) async {
    return await afterUserPhotoUpload(
      'coverPhotoUrl',
      imagePath,
    );
  }

  /// Works after the user's photo is uploaded.
  ///
  /// Deletes existing photo and updates the user's public data with the given imagePath
  /// Updates 'hasPhoto' field in the user's pub data document.
  Future<void> afterUserPhotoUpload(String fieldName, String? imagePath) async {
    dog("UserService.afterUserPhotoUpload() called with fieldName: $fieldName");

    if (imagePath == null || imagePath == "") {
      dog("imagePath is empty.");
      return;
    }

    final userPublicData = await getPublicData();

    String? fieldNameValue = userPublicData!.data[fieldName];

    /// the user has exising profile photo?
    if (fieldNameValue != null && fieldNameValue != "") {
      /// same as the new profile photo?
      if (p.basename(fieldNameValue) == p.basename(imagePath)) {
        dog("Upload photo is same as the existing profile photo.");
        return;
      }
      dog("Deleting existing profile photo.");
      // Delete the existing profile photo. Ignore if there is any error.
      try {
        await StorageService.instance.delete(fieldNameValue);
      } catch (e) {
        dog("Error ignored on deleting existing profile photo; $e");
      }
    }

    dog("Updating user public data.");
    await myUserPublicDataRef.update({
      fieldName: imagePath,
      if (fieldName == 'photoUrl') 'hasPhoto': true,
    });
  }

  newCommentSubscribers(List<DocumentReference> userReferences) async {
    if (userReferences.isEmpty) {
      return [];
    }

    List<Future<UserSettingModel>> futures = [];
    for (final ref in userReferences) {
      futures.add(UserSettingService.instance.get(ref.id));
    }

    final results = await Future.wait<UserSettingModel>(futures);

    final List<DocumentReference> subscribers = [];
    for (final setting in results) {
      if (setting.notifyNewComments == true) {
        subscribers.add(setting.userDocumentReference);
      }
    }
    return subscribers;
  }

  /// Add the new post and remove the oldest.
  ///
  /// If the number of recentPosts is greater than Config.instance.noOfRecentPosts,
  /// it will remove the oldest post.
  recentPosts(PostModel post) {
    List recentPosts = pub.recentPosts as List<dynamic>;
    if (recentPosts.length >= Config.instance.noOfRecentPosts) {
      recentPosts.removeRange(
          Config.instance.noOfRecentPosts - 1, recentPosts.length);
    }
    recentPosts.insert(0, feed(post));
    return recentPosts;
  }

  /// Get feed data from the post.
  UserPublicDataRecentPostModel feed(PostModel post) {
    return UserPublicDataRecentPostModel(
      postDocumentReference: post.ref,
      createdAt: post.createdAt,
      title: post.safeTitle,
      content: post.safeContent,
      photoUrl: post.files.isNotEmpty ? post.files.first : null,
    );
  }

  /// Login or register.
  ///
  /// If the user is not found, it will create a new user.
  ///
  /// Use this for anonymous login, or for test.
  Future loginOrRegister(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on fa.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
        rethrow;
      } else {
        log(e.toString());
        rethrow;
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  /// Get the user's public data.
  ///
  /// User's email is a private information and should be accessed by the user.
  /// Use this for test purpose. Save the user's email in the user's public data.
  /// And serach it.
  Future<UserModel> getByEmail(String email) async {
    final snapshot = await publicDataCol.where('email', isEqualTo: email).get();
    if (snapshot.docs.isEmpty) {
      throw Exception("User not found.");
    }
    return UserModel.fromSnapshot(snapshot.docs.first);
  }

  /// Follow a user
  ///
  Future follow(DocumentReference userDocumentReference) async {
    await publicRef.update({
      'followings': FieldValue.arrayUnion([userDocumentReference]),
    });
  }

  /// Reset the followings
  ///
  Future clearFollowings() async {
    await publicRef.update({
      'followings': [],
    });
  }

  /// Get feeds of the login user
  ///
  /// [noOfFollowers] is the number of followers to get. If it is 0, it will get all the followers.
  ///
  /// If it has no feeds, it will return an empty array.
  Future<List<RecentPostsStruct>> feeds({
    int noOfFollowers = 0,
  }) async {
    if (pub.followings!.isEmpty) {
      return [];
    }

    /// Get the users that I follow, ordered by last post created at.
    ///
    Query q = db
        .collection('users_public_data')
        .where('userDocumentReference', whereIn: pub.followings!.toList())
        .orderBy('lastPostCreatedAt', descending: true);

    /// Limit the number of (following) users to get if the app needs to display only a few posts.
    if (noOfFollowers > 0) {
      q = q.limit(noOfFollowers);
    }

    final usersQuerySnapshot = await q.get();

    if (usersQuerySnapshot.size == 0 || usersQuerySnapshot.docs.isEmpty) {
      return [];
    }

    // Merge the objects inside the array of usersQuerySnapshot.docs into a single array
    // order by the feild timestamp in that object in descending order.
    final List<RecentPostsStruct> allRecentPosts = [];
    for (final doc in usersQuerySnapshot.docs) {
      // final data = doc.data() as Map<String, dynamic>;
      // final user = UserPublicDataModel.fromSnapshot(doc);
      final user = UsersPublicDataRecord.getDocumentFromData(
          doc.data() as Map<String, dynamic>, doc.reference);
      if (user.recentPosts != null) {
        allRecentPosts.addAll(user.recentPosts!.toList());
      }
    }
    if (allRecentPosts.isEmpty) {
      return [];
    }

    /// sort allRecentPosts by timestamp
    allRecentPosts.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

    return allRecentPosts;
  }

  /// Get feeds of the login user
  ///
  /// If it has no feeds, it will return an empty array.
  Future<List<Map<String, dynamic>>> jsonFeeds({
    int noOfFollowers = 0,
  }) async {
    final List<RecentPostsStruct> feeds = await this.feeds(
      noOfFollowers: noOfFollowers,
    );

    return feeds
        .map((e) => {
              'postDocumentReference': e.postDocumentReference,
              'createdAt': e.createdAt,
              'title': e.title,
              'content': e.content,
              'photoUrl': e.photoUrl,
            })
        .toList();
  }

  /// Accept referral invitation
  ///
  /// return [true] on sucess and [false] if the user already has a referral.
  Future<bool> acceptInvitation(DocumentReference invitor) async {
    try {
      final me = await getPublicData();
      if (me!.referral != null) {
        return false;
      }
    } catch (e) {
      /// If the user is not found, it will create the public data document for the user.
    }

    await publicRef.set(
      {
        'referral': invitor,
        'referralAcceptedAt': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );

    return true;
  }

  /// 1분에 한번씩 사용자 채팅 메시지 수를 증가한다.
  ///
  /// 채팅을 입력 할 때 마다 카운트하면, 너무 빠르게 사용자 문서가 증가해서, 1분에 1씩 증가한다.
  ///
  /// 즉, 1분이 지나서, 채팅을 입력하면 카운트가 1 증가한다.
  ///
  /// If the user sends more than one message in a minute, it will count only 1.
  DateTime? lastChatTime;
  countChatMessage() {
    lastChatTime ??= DateTime.now();
    if (DateTime.now().difference(lastChatTime!).inSeconds <
        Config.chatCountInterval) {
      return;
    }

    /// 지정된 시간 [Config.chatCountInterval] 이 지났음. 초기화.
    lastChatTime = DateTime.now();

    publicRef.update({
      'chatMessageCount': FieldValue.increment(1),
    });
  }

  /// 사용자 정보 업데이트

  Future<void> updatePhotoUrl(String url) {
    return publicRef.update(
      {
        'photoUrl': url,
      },
    );
  }
}
