// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fireflow/fireflow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';
import 'package:file_picker/file_picker.dart';

/// 사진을 여러장 업로드하는 조건
/// 웹이 아니고(앱에서만 가능), 사진 갤러리에서만 사진을 가져오며, multiImage 가 true 인 경우

const allowedFormats = {'image/png', 'image/jpeg', 'video/mp4', 'image/gif'};

class SelectedMedia {
  const SelectedMedia(this.storagePath, this.bytes);
  final String storagePath;
  final Uint8List bytes;
}

enum MediaSource {
  photoGallery,
  videoGallery,
  camera,
  file,
}

/// Firebase Storage Service
///
/// Refer readme file for details.
///
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

  /// Returns the metadata of the file.
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

  Future<List<SelectedMedia>?> selectMedia({
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
    bool isVideo = false,
    MediaSource mediaSource = MediaSource.camera,
    bool multiImage = false,
  }) async {
    final picker = ImagePicker();
    // User must sign-in before uploading media.
    final String currentUserUid = FirebaseAuth.instance.currentUser?.uid ?? '';

    /// Upload multiple images at once.
    ///
    /// The conditions of uploading muliple images are
    ///   - [multiImage] is true
    ///   - the app is running as mobile app(not web)
    ///   - the user selects 'Upload Images' from the menu
    ///
    if (mediaSource == MediaSource.photoGallery &&
        multiImage &&
        kIsWeb == false) {
      final pickedMediaFuture = picker.pickMultiImage(
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: imageQuality,
      );
      final pickedMedia = await pickedMediaFuture;
      if (pickedMedia == null || pickedMedia.isEmpty) {
        return null;
      }
      return Future.wait(pickedMedia.asMap().entries.map((e) async {
        final index = e.key;
        final media = e.value;
        final mediaBytes = await media.readAsBytes();
        final path = storagePath(currentUserUid, media.name, false, index);
        return SelectedMedia(path, mediaBytes);
      }));
    }

    /// If a user selects 'Upload Any File' from the menu, then it will open file picker.
    if (mediaSource == MediaSource.file) {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null && result.files.isNotEmpty) {
        late final Uint8List fileBytes;
        late final String fileName;
        if (kIsWeb) {
          fileBytes = result.files.first.bytes!;
          fileName = result.files.first.name;
        } else {
          File file = File(result.files.single.path!);
          fileBytes = await file.readAsBytes();
          fileName = file.path.split('/').last;
        }
        return [
          SelectedMedia(
            storagePath(currentUserUid, fileName, isVideo),
            fileBytes,
          ),
        ];
      } else {
        // User canceled the picker
        return [];
      }
    }

    /// When a user selects one of 'Upload Image', 'Upload Video' or 'Camera'
    /// from the menu, then it will open image picker or video picker.
    final source = mediaSource == MediaSource.camera
        ? ImageSource.camera
        : ImageSource.gallery;
    final pickedMediaFuture = isVideo
        ? picker.pickVideo(source: source)
        : picker.pickImage(
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            imageQuality: imageQuality,
            source: source,
          );
    final pickedMedia = await pickedMediaFuture;
    final mediaBytes = await pickedMedia?.readAsBytes();
    if (mediaBytes == null) {
      return null;
    }
    final path = storagePath(currentUserUid, pickedMedia!.name, isVideo);
    return [SelectedMedia(path, mediaBytes)];
  }

  bool validateFileFormat(String filePath, BuildContext context) {
    if (allowedFormats.contains(mime(filePath))) {
      return true;
    }
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text('Invalid file format: ${mime(filePath)}'),
      ));
    return false;
  }

  String storagePath(String uid, String filePath, bool isVideo, [int? index]) {
    final timestamp = DateTime.now().microsecondsSinceEpoch;
    // Workaround fixed by https://github.com/flutter/plugins/pull/3685
    // (not yet in stable).
    final ext = isVideo ? 'mp4' : filePath.split('.').last;
    final indexStr = index != null ? '_$index' : '';
    return 'users/$uid/uploads/$timestamp$indexStr.$ext';
  }

  void showUploadMessage(BuildContext context, String message,
      {bool showLoading = false}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              if (showLoading)
                const Padding(
                  padding: EdgeInsetsDirectional.only(end: 10.0),
                  child: CircularProgressIndicator(),
                ),
              Text(message),
            ],
          ),
        ),
      );
  }

  Future<String?> uploadData(String path, Uint8List data) async {
    final storageRef = FirebaseStorage.instance.ref().child(path);
    final metadata = SettableMetadata(contentType: mime(path));
    final result = await storageRef.putData(data, metadata);
    return result.state == TaskState.success
        ? result.ref.getDownloadURL()
        : null;
  }

  /// Upload media to firebase storage.
  ///
  /// If [allowPhoto] is set to true, then the user can upload photos.
  /// If [allowVideo] is set to true, then the user can upload videos.
  /// [multiImage] is only available when the media source is set to 'image'
  ///
  /// It returns a list of urls of the uploaded media. If there is no media uploaded, then it returns an empty list.
  ///
  /// @TODO - Add Translations for all the text.
  Future<List<String>> uploadMedia({
    required BuildContext context,
    required bool allowPhoto,
    required bool allowVideo,
    required bool allowAnyfile,
    required bool multiImage,
    required double maxWidth,
    required double maxHeight,
    required int imageQuality,
  }) async {
    dog(
      'uploadMedia() called with context: ..., maxWidth: $maxWidth, maxHeight: $maxHeight, imageQuality: $imageQuality, allowPhoto: $allowPhoto',
    );

    final backgroundColor = Theme.of(context).colorScheme.onPrimary;
    final textColor = Theme.of(context).colorScheme.primary;

    /// * It's a function inside a function. Display bottomsheet to choose media source
    createUploadMediaListTile(String label, MediaSource mediaSource) =>
        ListTile(
          title: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          tileColor: backgroundColor,
          dense: false,
          onTap: () => Navigator.pop(
            context,
            mediaSource,
          ),
        );
    final mediaSource = await showModalBottomSheet<MediaSource>(
        context: context,
        backgroundColor: backgroundColor,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!kIsWeb) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: ListTile(
                    title: Text(
                      'Choose Source',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textColor.withOpacity(0.65),
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    tileColor: backgroundColor,
                    dense: false,
                  ),
                ),
                const Divider(),
              ],
              if (allowPhoto && allowVideo) ...[
                createUploadMediaListTile(
                  'Gallery (Photo)',
                  MediaSource.photoGallery,
                ),
                const Divider(),
                createUploadMediaListTile(
                  'Gallery (Video)',
                  MediaSource.videoGallery,
                ),
              ] else if (allowPhoto)
                createUploadMediaListTile(
                  'Gallery',
                  MediaSource.photoGallery,
                )
              else
                createUploadMediaListTile(
                  'Gallery',
                  MediaSource.videoGallery,
                ),
              if (allowAnyfile) ...[
                const Divider(),
                createUploadMediaListTile('Upload Any File', MediaSource.file),
              ],
              if (!kIsWeb) ...[
                const Divider(),
                createUploadMediaListTile('Camera', MediaSource.camera),
                const Divider(),
              ],
              const SizedBox(height: 10),
            ],
          );
        });
    if (mediaSource == null) {
      // Finished without selecting a media source
      return [];
    }

    /// Select media from source. It may be a list of images or a single video.
    final List<SelectedMedia>? selectedMedia = await selectMedia(
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      imageQuality: imageQuality,
      isVideo: mediaSource == MediaSource.videoGallery ||
          (mediaSource == MediaSource.camera && allowVideo && !allowPhoto),
      mediaSource: mediaSource,
      multiImage: multiImage,
    );
    if (selectedMedia == null || selectedMedia.isEmpty) {
      // Finished without selecting a media
      return [];
    }

    /// If user selected a 'Upload Any File', then don't check the file format.
    if (mediaSource == MediaSource.file ||
        selectedMedia
            .every((m) => validateFileFormat(m.storagePath, context))) {
      showUploadMessage(
        context,
        'Uploading file...',
        showLoading: true,
      );
      final List<String> downloadUrls = List<String>.from((await Future.wait(
              selectedMedia
                  .map((m) async => await uploadData(m.storagePath, m.bytes))))
          .where((u) => u != null)
          .map((u) => u!)
          .toList());
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      if (downloadUrls.length == selectedMedia.length) {
        showUploadMessage(
          context,
          'Success!',
        );
        dog('---> uploaded $downloadUrls');
        return downloadUrls;
      } else {
        showUploadMessage(
          context,
          'Failed to upload media',
        );
        return [];
      }
    }

    /// Return empty array if the user cancelled the upload
    /// Or contains any image/video that has wrong format.
    return [];
  }

  /// Get all the files from Firebase Storage and store them into /storage-files collection.
  Future updateStorageFiles() async {
    await deleteStorageFiles();

    final storageRef = FirebaseStorage.instance.ref().child("users");
    final listResult = await storageRef.listAll();

    List<Reference> allFiles = [];

    /// Get files by user
    for (final prefix in listResult.prefixes) {
      final path = "users/${prefix.name}/uploads";
      final userUploadRef = FirebaseStorage.instance.ref().child(path);
      final userUploads = await userUploadRef.listAll();

      // dog('path: $path, items: ${userUploads.items.length}');
      for (final item in userUploads.items) {
        allFiles.add(item);
      }
    }

    /// chunk the items into 100 items each.
    final List chunks = chunkArray<Reference>(allFiles, 100);
    for (final chunk in chunks) {
      List<Future> futures = [];
      for (final Reference item in chunk) {
        futures.add(item.getDownloadURL());
        futures.add(item.getMetadata());
      }
      List results = await Future.wait(futures);

      /// results is a list of [url, meta, url, meta, ...]
      final List<Map<String, dynamic>> docs = [];
      for (int i = 0; i < results.length; i += 2) {
        final url = results[i];
        final meta = results[i + 1];
        final uid = meta.fullPath.split('/')[1];
        final data = {
          'url': url,
          'uid': uid,
          'userDocumentReference': UserService.instance.doc(uid),
          'name': meta.name,
          'fullPath': meta.fullPath,
          'size': meta.size,
          'contentType': meta.contentType,
          'createdAt': meta.timeCreated,
        };

        docs.add(data);
      }
      if (docs.isNotEmpty) {
        final batch = FirebaseFirestore.instance.batch();
        for (final doc in docs) {
          final path = doc['uid'] + '-' + doc['name'];
          final ref =
              FirebaseFirestore.instance.collection('storage_files').doc(path);
          batch.set(ref, doc);
        }
        batch.commit();
      }
    }
  }

  /// Delete all the documents under /storage_files collection.
  Future deleteStorageFiles() async {
    final ref = FirebaseFirestore.instance.collection('storage_files');
    final snapshot = await ref.get();
    final batch = FirebaseFirestore.instance.batch();
    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }
    return batch.commit();
  }
}
