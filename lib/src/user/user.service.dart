import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireflow/fireflow.dart';
// import 'package:fireflow/src/backend/schema/posts_record.dart';
import 'package:path/path.dart' as p;
import 'package:rxdart/subjects.dart';

UserModel get my => UserService.instance.my;

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

  FirebaseAuth get auth => FirebaseAuth.instance;

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

  /// The login user's Firebase User object.
  User get currentUser => auth.currentUser!;

  /// Returns true if the user is logged in.
  bool get isLoggedIn => auth.currentUser != null;
  bool get notLoggedIn => !isLoggedIn;

  /// The login user's public data document stream.
  StreamSubscription? mySubscription;

  /// The login user's data model.
  ///
  /// It is updated (synced) on /users/<uid> document changes.
  UserModel? _my;
  UserModel get my => _my!;
  set my(UserModel? v) => _my = v;

  final BehaviorSubject<UserModel?> onMyChange =
      BehaviorSubject<UserModel?>.seeded(null);

  /// 로그아웃
  ///
  ///
  logout() {
    my = null;
    onMyChange.add(null);
    mySubscription?.cancel();
  }

  /// Get user document by uid.
  ///
  /// Note, it returns user data model. Not the user's public data.
  Future<UserModel> get([String? id]) async {
    final snapshot = await doc(id ?? uid).get();
    return UserModel.fromSnapshot(snapshot);
  }

  /// /users 컬렉션 생성
  ///
  /// FF 에서는 회원 가입 후, 바로 이런 코드를 호출하여 /users 컬렉션을 생성하지만,
  /// FF 를 쓰지 않는 경우, 또는 그 외의 예외적인 경우에서, /users 문서가 생성되지 않았을 경 대비, 성성한다.
  ///
  /// AppService 에서 한번만 호출됨.
  Future maybeGenerateUserDocument() async {
    await maybeCreateUser(FirebaseAuth.instance.currentUser!);
  }

  /// 사용자 문서 업데이트 Listen & 최신 문서 업데이트
  ///
  /// 예를 들어, 로그인한 사용자가 follow/unfollow 할 때, 사용자 문서가 업데이트되는데, 이러한 사용자 문서
  /// 변경을 실시간으로 my 변수에 업데이트한다.
  ///
  /// 따라서, my 변수를 많은 곳에서 활용하면 된다.
  ///
  /// 참고, 사용자가 갑자기 로그아웃(또는 프로그램적으로 다른 사용자로 갑자기 로그인)을 하면, listen() 을 할 때,
  /// 해당 사용자가 이미 로그아웃을 한 상태이므로 permission denied 가 발생한다.
  /// 이것은 너무 흔한 permission denied 이며, 큰 문제는 아니지만, 제대로 처리하기 위해서는 logout() 한다.
  ///
  ///
  listenUserDocument() {
    mySubscription?.cancel();
    dog('listenUserDocument(); doc updated; uid: $uid ${ref.path}');
    mySubscription = ref.snapshots().listen((snapshot) {
      if (snapshot.exists) {
        // 사용자 문서가 변경되었다.
        my = UserModel.fromSnapshot(snapshot);
        onMyChange.add(my);

        dog('listenUserDocument(): ${my.displayName}, ${my.updatedAt}');

        /// 사용자 필드 옮기기
        /// 주의, 사용자 문서 업데이트를 listen() 하고 있는 중에 다시 사용자 문서 업데이트를 한다. 재귀적 호출을 하는지 잘 살펴봐야 한다.
        _moveUserData();
      }
    });
  }

  /// 개발자가 사용자의 email 이나 phone_number 를 다른 컬렉션에 저장하고 싶을 때,
  /// README 참고
  _moveUserData() async {
    if (Config.instance.moveUserPrivateDataTo == null) return;

    if (my.email.isNotEmpty || my.phoneNumber.isNotEmpty) {
      dog('moveUserData() -> Going to move user data; email: ${my.email}, phone_number: ${my.phoneNumber}');

      /// backup first,
      final email = my.email;
      final phoneNumber = my.phoneNumber;
      await update(
        email: FieldValue.delete(),
        phoneNumber: FieldValue.delete(),
      );

      try {
        await FirebaseFirestore.instance
            .collection(Config.instance.moveUserPrivateDataTo!)
            .doc(uid)
            .set({
          if (email.isNotEmpty) 'email': email,
          if (phoneNumber.isNotEmpty) 'phone_number': phoneNumber,
        }, SetOptions(merge: true));
      } catch (e) {
        dog('-- -- -- -- -> Failed to move user private data into ${Config.instance.moveUserPrivateDataTo} --> Check if the collection has permission.');
        rethrow;
      }
    }
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
  ///
  /// 기존 파일을 삭제하는데 실패해도, 이 함수는 exception 을 던지지 않는다. 즉, FF 에서, 파일 삭제 실패해도 계속 다음 액션을 진행 할 수 있다.
  Future<void> afterUserPhotoUpload(String fieldName, String? imagePath) async {
    dog("UserService.afterUserPhotoUpload() called with fieldName: $fieldName");

    if (imagePath == null || imagePath == "") {
      dog("imagePath is empty.");
      return;
    }

    String? fieldValue;
    if (fieldName == 'photoUrl') {
      fieldValue = my.photoUrl;
    } else if (fieldName == 'coverPhotoUrl') {
      fieldValue = my.coverPhotoUrl;
    } else {
      return;
    }

    /// 사용자 사진이 존재하는가?
    if (fieldValue != null && fieldValue != "") {
      // 새로 업로드 하려는 파일(이름)이, 기존의 파일과 같으면 리턴
      if (p.basename(fieldValue) == p.basename(imagePath)) {
        dog("Upload photo is same as the existing profile photo.");
        return;
      }
      dog("Deleting existing profile photo.");
      // 새로운 파일 업로드하는데, 기존 파일이 존재하면 삭제. 에러가 있으면 무시. 즉, 다음 async/awiat 작업을 계속한다.
      try {
        await StorageService.instance.delete(fieldValue);
      } catch (e) {
        // 에러 던지지 않음
        dog("Error ignored on deleting existing profile photo; $e");
      }
    }

    dog("Updating user public data.");
    await update(extra: {
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

  /// 새로운 글 1개를 입력하여, my.recentPosts 에 추가해서 리턴한다.
  ///
  /// If the number of recentPosts is greater than Config.instance.noOfRecentPosts,
  /// it will remove the oldest post.
  List<FeedModel> recentPosts(PostModel post) {
    List<FeedModel> recentPosts = my.recentPosts;
    if (recentPosts.length >= Config.instance.noOfRecentPosts) {
      recentPosts.removeRange(
          Config.instance.noOfRecentPosts - 1, recentPosts.length);
    }
    recentPosts.insert(0, feed(post));
    return recentPosts;
  }

  /// 글 모델을 입력 받아, 피드로 저장 할 수 있도록 JSON 으로 리턴한다.
  FeedModel feed(PostModel post) {
    return FeedModel.fromJson({
      'postDocumentReference': post.reference,
      'userDocumentReference': my.reference,
      'createdAt': post.createdAt,
      'title': safeString(post.title),
      'content': safeString(post.content),
      'photoUrl': post.files.isNotEmpty ? post.files.first : null,
    });
  }

  /// 이메일 로그인 또는 가입
  ///
  /// 테스트 용 또는 기타 용도로 쓸 수 있다.
  ///
  /// UserModel 을 리턴한다.
  ///
  /// 주의, 이 함수는 로그아웃을 먼저 한다.
  Future<UserModel> loginOrRegister(String email, String password) async {
    UserService.instance.logout();
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return UserModel.fromFirebaseUser(credential.user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        return UserModel.fromFirebaseUser(credential.user!);
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
    final snapshot = await col.where('email', isEqualTo: email).get();
    if (snapshot.docs.isEmpty) {
      throw Exception("User not found.");
    }
    return UserModel.fromSnapshot(snapshot.docs[0]);
  }

  /// Follow a user
  ///
  Future follow(DocumentReference userDocumentReference) async {
    await update(
      followings: FieldValue.arrayUnion([userDocumentReference]),
    );
  }

  /// Reset the followings
  ///
  Future clearFollowings() async {
    await update(
      followings: FieldValue.delete(),
    );
  }

  /// 로그인 한 사용자의 피드를 가져온다.
  ///
  /// 여기서 피드는, 내가 following 하는 사용자들의 최신 글 목록이다. 즉, 나의 최신 글 목록이 아니다.
  ///
  /// [noOfFollowers] is the number of followers to get. If it is 0, it will get all the followers.
  ///
  /// If it has no feeds, it will return an empty array.
  Future<List<FeedModel>> feeds({
    int noOfFollowers = 0,
  }) async {
    if (my.followings.isEmpty) {
      return [];
    }

    /// Get the users that I follow, ordered by last post created at.
    ///
    Query q = col
        .where('uid', whereIn: my.followings.map((e) => e.id).toList())
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
    final List<FeedModel> allRecentPosts = [];
    for (final doc in usersQuerySnapshot.docs) {
      final user = UserModel.fromSnapshot(doc);
      allRecentPosts.addAll(user.recentPosts);
    }
    if (allRecentPosts.isEmpty) {
      return [];
    }

    /// sort allRecentPosts by timestamp
    allRecentPosts.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return allRecentPosts;
  }

  /// Accept referral invitation
  ///
  /// return [true] on sucess and [false] if the user already has a referral.
  ///
  Future<bool> acceptInvitation(DocumentReference invitor) async {
    try {
      // final me = await getPublicData();
      return false;
    } catch (e) {
      /// If the user is not found, it will create the public data document for the user.
    }

    await update(
      referral: invitor,
      referralAcceptedAt: FieldValue.serverTimestamp(),
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

    update(
      chatMessageCount: FieldValue.increment(1),
    );
  }

  /// 사용자 정보 업데이트
  ///
  /// 참고, 현재 로그인한 사용자 정보만 업데이트한다.
  Future<void> update({
    dynamic email,
    dynamic phoneNumber,
    String? displayName,
    String? photoUrl,
    FieldValue? chatMessageCount,
    FieldValue? followings,
    FieldValue? blockedUsers,
    DocumentReference? referral,
    FieldValue? referralAcceptedAt,
    FieldValue? noOfPosts,
    FieldValue? noOfComments,
    FieldValue? lastPostCreatedAt,
    FeedModel? lastPost,
    List<FeedModel>? recentPosts,
    Map<String, dynamic>? extra,
  }) {
    return ref.update({
      if (email != null) 'email': email,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (displayName != null) 'display_name': displayName,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (chatMessageCount != null) 'chat_message_count': chatMessageCount,
      if (followings != null) 'followings': followings,
      if (blockedUsers != null) 'blockedUsers': blockedUsers,
      if (referral != null) 'referral': referral,
      if (referralAcceptedAt != null) 'referralAcceptedAt': referralAcceptedAt,
      if (noOfPosts != null) 'noOfPosts': noOfPosts,
      if (noOfComments != null) 'noOfComments': noOfComments,
      if (lastPostCreatedAt != null) 'lastPostCreatedAt': lastPostCreatedAt,
      if (lastPost != null) 'lastPost': lastPost.toJson(),
      if (recentPosts != null)
        'recentPosts': recentPosts.map((e) => e.toJson()).toList(),
      if (extra != null) ...extra,
    });
  }

  // 사용자가 처음 회원 가입할 때 FF 가 /users 컬렉션을 생성하기 위한 코드.
  // 사용자 문서가 이미 생성되었으면, 실행하지 않는다.
  // Fireflow 에서도, 앱이 실행 될 때 마다 이 코드를 한번 실행한다. 그래서 혹시, /users/<uid> 문서가 존재하지 않으면 생성한다.
  Future maybeCreateUser(User user) async {
    final userRecord = doc(user.uid);
    final userExists = await userRecord.get().then((u) => u.exists);
    if (userExists) {
      return;
    }

    final Map<String, dynamic> userData = {
      'email': user.email,
      'display_name': user.displayName,
      'photo_url': user.photoURL,
      'uid': user.uid,
      'phone_number': user.phoneNumber,
    };
    userData['created_time'] = FieldValue.serverTimestamp();

    await userRecord.set(userData);
  }

  /// 로그인한 사용자의 feed 삭제.
  ///
  /// feed 는 나의 최근 글 목록이다.
  Future clearFeeds() async {
    dog('Clear all feeds of ${my.displayName}}');
    await UserService.instance.update(extra: {
      'lastPost': FieldValue.delete(),
      'recentPosts': FieldValue.delete(),
    });
  }
}
