import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireflow/fireflow.dart';
import 'package:fireflow/src/storage/storage.service.dart';
import 'package:path/path.dart' as p;

/// UserService is a singleton class that provides necessary service for user
/// related features.
///
class UserService {
  // create a singleton method of UserService
  static UserService get instance => _instance ?? (_instance = UserService());
  static UserService? _instance;

  String get uid => FirebaseAuth.instance.currentUser!.uid;
  DocumentReference get myUserRef =>
      FirebaseFirestore.instance.collection('users').doc(uid);
  DocumentReference get myUserPublicDataRef =>
      FirebaseFirestore.instance.collection('users_public_data').doc(uid);

  User get my => FirebaseAuth.instance.currentUser!;

  userPublicDataDocumentExists() async {
    final doc = await myUserPublicDataRef.get();
    return doc.exists;
  }

  /// Warning, this method may throw an exception if it is being called immediately after the user is signed in for the first time.
  /// The `/users/{uid}` document may be created after the user is signed in.
  Future<UserModel> getUser() async {
    // get the user's data from the database
    final snapshot = await myUserRef.get();
    return UserModel.fromSnapshot(snapshot);
  }

  Future<UserPublicDataModel> getUserPublicData() async {
    // get the user's public data from the database
    final snapshot = await myUserPublicDataRef.get();
    return UserPublicDataModel.fromSnapshot(snapshot);
  }

  /// Creates /users_public_data/{uid} if it does not exist.
  /// This will crate /users_public_data/{uid} only if the user is logged in for the first time.
  generateUserPublicDataDocument() async {
    if (await userPublicDataDocumentExists()) {
      return;
    }

    await myUserPublicDataRef.set({
      'displayName': my.displayName ?? '',
      'photoUrl': my.photoURL ?? '',
      'uid': uid,
      'userDocumentReference': myUserRef,
      'registeredAt': FieldValue.serverTimestamp(),
    });

    dog("UserService.generateUserPublicData() - user public data created.");
  }

  /// Updates the user's public data with the given imagePath
  afterProfilePhotoUpload(String? imagePath) async {
    return await afterUserPhotoUpload('photoUrl', imagePath);
  }

  /// Updates the user's public data with the given imagePath
  Future<void> afterCoverPhotoUpload(String? imagePath) async {
    return await afterUserPhotoUpload('coverPhotoUrl', imagePath);
  }

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
