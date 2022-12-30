import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fireflow/fireflow.dart';

/// Firebase Storage Service
///
/// Refer readme file for details.
class StorageService {
  static StorageService get instance =>
      _instance ?? (_instance = StorageService());
  static StorageService? _instance;

  final storage = FirebaseStorage.instance;

  Reference get uploadsFolder =>
      storage.ref().child('users').child(UserService.instance.uid);

  Reference ref(String url) {
    return storage.refFromURL(url);
  }

  /// Returns true if the file exists on storage. Or false.
  Future<bool> exists(String url) async {
    if (url.startsWith('http')) {
      try {
        await ref(url).getDownloadURL();
        return true;
      } catch (e) {
        // debugPrint('getDownloadUrl(); $e');
        return false;
      }
    } else {
      return false;
    }
  }

  Future<FullMetadata> getMetadata(String url) {
    return ref(url).getMetadata();
  }

  /// Delete uploaded file.
  ///
  /// If it's an image, then it will delete the thumbnail image.
  /// If it's not a file from firebase storage, it does not do anything.
  ///
  ///
  /// If it's an image url, then the [url] must be the original image url.
  /// If [url] does exist on storage, then it will not delete.
  ///
  /// Ignore object-not-found exception.
  ///
  /// If it throws [firestore_storage/unauthorized], then the user may try to delete file that does not belong him.
  /// This may happens in testing or putting url(photoUrl) of other user's photo.
  ///
  ///
  Future<void> delete(String url) async {
    if (await exists(url) == false) return;
    await ref(url).delete();
  }
}
