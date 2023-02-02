import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:fireflow/fireflow.dart';
import 'package:path/path.dart' as p;
import 'package:rxdart/subjects.dart';

/// UserService is a singleton class that provides necessary service for user
/// related features.
///
class UserService {
  // create a singleton method of UserService
  static UserService get instance => _instance ?? (_instance = UserService());
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

  get publicRef => myUserPublicDataRef;

  /// The login user's Firebase User object.
  fa.User get currentUser => auth.currentUser!;

  /// Returns true if the user is logged in.
  bool get isLoggedIn => auth.currentUser != null;
  bool get notLoggedIn => !isLoggedIn;

  /// The login user's public data document stream.
  StreamSubscription? publicDataSubscription;

  /// The login user's public data model.
  ///
  /// It listens the changes of the user's public data document and update [my] variable.
  /// Note that, this is always upto date. So, you don't have to get the login user's
  /// public data document from the firestore.
  ///
  late UserPublicDataModel my;

  final BehaviorSubject<UserPublicDataModel?> onChange =
      BehaviorSubject<UserPublicDataModel?>.seeded(null);

  /// check if user's public data document exists
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
  Future<UserPublicDataModel> getPublicData() async {
    // get the user's public data from the database
    final snapshot = await myUserPublicDataRef.get();
    return UserPublicDataModel.fromSnapshot(snapshot);
  }

  /// Get user document by uid.
  ///
  /// Note, it's not getting the user's public data.
  Future<UserPublicDataModel> get([String? id]) async {
    return UserPublicDataModel.fromSnapshot(await doc(id ?? uid).get());
  }

  /// Creates /users_public_data/{uid} if it does not exist.
  /// This will crate /users_public_data/{uid} only if the user is logged in for the first time.
  generateUserPublicDataDocument() async {
    ///
    if (await userPublicDataDocumentExists() == false) {
      /// Generate the user's public data document
      await myUserPublicDataRef.set({
        'displayName': currentUser.displayName ?? '',
        'photoUrl': currentUser.photoURL ?? '',
        'uid': uid,
        'userDocumentReference': ref,
        'registeredAt': FieldValue.serverTimestamp(),
      });

      /// Create user's document under `/users` collection.
      /// Mostly, user document will be created automatically by flutterflow
      /// when the user is signed in. But there are some cases where the
      /// app is not developed by fireflow.
      /// In that case, it will create the user document when user's public
      /// data document is being created. So, it will check the exitence only
      /// once and it will save money.
      final snapshot = await myRef.get();
      if (snapshot.exists == false) {
        await myRef.set({
          'uid': uid,
          if ((currentUser.email ?? '').isNotEmpty) 'email': currentUser.email,
          'created_time': FieldValue.serverTimestamp(),
        });
      }
    }

    /// Update user's document with the user's public data document reference
    /// To make sure that the user's public data document reference always
    /// exists in /users/{uid}, it updates on every boot.
    await myRef.update({
      'userPublicDataDocumentReference': myUserPublicDataRef,
    });

    dog("UserService.generateUserPublicData() - user public data generated at ${myUserPublicDataRef.path}");
  }

  /// Listen the changes of users_public_data/{uid}.
  ///
  /// It listens the update of the login user's public data document and
  /// - keep the user's public data in memory.
  /// - update the user's public data into Supabase if neccessary.
  listenUserPublicData() {
    /// Observe the user public data.
    publicDataSubscription?.cancel();
    publicDataSubscription = UserService.instance.myUserPublicDataRef
        .snapshots()
        .listen((snapshot) async {
      if (snapshot.exists) {
        my = UserPublicDataModel.fromSnapshot(snapshot);
        onChange.add(my);
        if (SupabaseService.instance.storeUsersPubicData) {
          /// Upsert the user public data to Supabase.
          final data = {
            'uid': my.uid,
            'display_name': my.displayName,
            'photo_url': my.photoUrl,
            'gender': my.gender,
            'birthday': my.birthday.toDate().toIso8601String(),
            'registered_at': my.registeredAt.toDate().toIso8601String(),
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
    return await afterUserPhotoUpload('photoUrl', imagePath);
  }

  /// Updates the user's public data with the given imagePath
  Future<void> afterCoverPhotoUpload(String? imagePath) async {
    return await afterUserPhotoUpload('coverPhotoUrl', imagePath);
  }

  /// Works after the user's photo is uploaded.
  ///
  /// Deletes existing photo and updates the user's public data with the given imagePath
  Future<void> afterUserPhotoUpload(String fieldName, String? imagePath) async {
    dog("UserService.afterUserPhotoUpload() called with fieldName: $fieldName");

    if (imagePath == null || imagePath == "") {
      dog("imagePath is empty.");
      return;
    }

    final userPublicData = await getPublicData();

    String? fieldNameValue = userPublicData.data[fieldName];

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
    List recentPosts = my.recentPosts ?? [];
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
  Future<List<UserPublicDataRecentPostModel>> feeds({
    int noOfFollowers = 0,
  }) async {
    /// Get the users that I follow, ordered by last post created at.
    ///
    Query q = db
        .collection('users_public_data')
        .where('userDocumentReference', whereIn: my.followings)
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
    final List<UserPublicDataRecentPostModel> allRecentPosts = [];
    for (final doc in usersQuerySnapshot.docs) {
      // final data = doc.data() as Map<String, dynamic>;
      final user = UserPublicDataModel.fromSnapshot(doc);
      if (user.recentPosts != null) allRecentPosts.addAll(user.recentPosts!);
    }
    if (allRecentPosts.isEmpty) {
      return [];
    }

    /// sort allRecentPosts by timestamp
    allRecentPosts.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return allRecentPosts;
  }

  /// Get feeds of the login user
  ///
  /// If it has no feeds, it will return an empty array.
  Future<List<Map<String, dynamic>>> jsonFeeds({
    int noOfFollowers = 0,
  }) async {
    final List<UserPublicDataRecentPostModel> feeds = await this.feeds(
      noOfFollowers: noOfFollowers,
    );

    return feeds.map((e) => e.toJson()).toList();
  }
}
