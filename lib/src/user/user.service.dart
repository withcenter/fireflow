import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  String get uid => FirebaseAuth.instance.currentUser!.uid;

  /// The login user's document reference
  DocumentReference get ref =>
      FirebaseFirestore.instance.collection('users').doc(uid);

  get myRef => ref;

  /// The login user's public data document reference
  DocumentReference get myUserPublicDataRef =>
      FirebaseFirestore.instance.collection('users_public_data').doc(uid);

  get publicRef => myUserPublicDataRef;

  /// The login user's Firebase User object.
  User get my => FirebaseAuth.instance.currentUser!;

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
        'displayName': my.displayName ?? '',
        'photoUrl': my.photoURL ?? '',
        'uid': uid,
        'userDocumentReference': ref,
        'registeredAt': FieldValue.serverTimestamp(),
      });
    }

    /// Update user's document with the user's public data document reference
    /// Make sure that the user's public data document reference always exists in /users/{uid}.
    await myRef.update({
      'userPublicDataDocumentReference': myUserPublicDataRef,
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
