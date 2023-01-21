import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as FA;
import 'package:fireflow/fireflow.dart';
import 'package:path/path.dart' as p;

/// UserService is a singleton class that provides necessary service for user
/// related features.
///
class UserService {
  // create a singleton method of UserService
  static UserService get instance => _instance ?? (_instance = UserService());
  static UserService? _instance;

  /// The Firebase Firestore instance
  FirebaseFirestore db = FirebaseFirestore.instance;

  /// The collection reference of the users collection
  CollectionReference get col => db.collection('users');

  /// Returns a document reference of the given id.
  DocumentReference doc(String id) => col.doc(id);

  /// The login user's uid
  String get uid => FA.FirebaseAuth.instance.currentUser!.uid;

  /// The login user's document reference
  DocumentReference get ref => FirebaseFirestore.instance.collection('users').doc(uid);

  DocumentReference get myRef => ref;

  /// The login user's public data document reference
  DocumentReference get myUserPublicDataRef => FirebaseFirestore.instance.collection('users_public_data').doc(uid);

  get publicRef => myUserPublicDataRef;

  /// The login user's Firebase User object.
  FA.User get currentUser => FA.FirebaseAuth.instance.currentUser!;

  /// Returns true if the user is logged in.
  bool get isLoggedIn => FA.FirebaseAuth.instance.currentUser != null;
  bool get notLoggedIn => !isLoggedIn;

  StreamSubscription? publicDataSubscription;

  /// The login user's public data model.
  ///
  /// The app is listening the changes of the user's public data document and update this model.
  /// So, [my] will always have the latest data.
  late UserPublicDataModel my;

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
  Future<UserPublicDataModel> getUserPublicData() async {
    // get the user's public data from the database
    final snapshot = await myUserPublicDataRef.get();
    return UserPublicDataModel.fromSnapshot(snapshot);
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

      /// Create user's document.
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
          'created_time': FieldValue.serverTimestamp(),
        });
      }
    }

    /// Update user's document with the user's public data document reference
    /// Make sure that the user's public data document reference always exists in /users/{uid}.
    await myRef.update({
      'userPublicDataDocumentReference': myUserPublicDataRef,
    });

    dog("UserService.generateUserPublicData() - user public data created.");
  }

  /// Listen the changes of users_public_data/{uid}.
  ///
  /// It listens the update of the login user's public data document and
  /// - keep the user's public data in memory.
  /// - update the user's public data into Supabase if neccessary.
  listenUserPublicData() {
    /// Observe the user public data.
    publicDataSubscription?.cancel();
    publicDataSubscription = UserService.instance.myUserPublicDataRef.snapshots().listen((snapshot) async {
      if (snapshot.exists) {
        my = UserPublicDataModel.fromSnapshot(snapshot);
        if (AppService.instance.supabase) {
          /// Upsert the user public data to Supabase.
          // await Supabase.instance.client
          //     .from(Config.instance.supabase.usersPublicData)

          await supabase.usersPublicData.upsert(
            {
              'uid': my.uid,
              'display_name': my.displayName,
              'gender': my.gender,
              'birthday': my.birthday.toDate().toIso8601String(),
              'registered_at': my.registeredAt.toDate().toIso8601String(),
            },
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

    final userPublicData = await getUserPublicData();

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
}
