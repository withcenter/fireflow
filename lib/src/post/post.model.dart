import 'package:cloud_firestore/cloud_firestore.dart';

/// PostModel is a class that represents a document of /posts.
///
class PostModel {
  final String category;
  final DocumentReference userDocumentReference;
  final String title;
  final String content;
  final Timestamp createdAt;
  final Timestamp updatedAt;
  final bool hasPhoto;
  final int noOfComments;
  final bool hasComment;
  final bool deleted;
  final List<DocumentReference> likes;
  final bool hasLike;
  final List<String> files;
  final bool wasPremiumUser;
  final bool emphasizePremiumUserPost;

  PostModel({
    required this.category,
    required this.title,
    required this.content,
    required this.userDocumentReference,
    required this.createdAt,
    required this.updatedAt,
    required this.hasPhoto,
    required this.noOfComments,
    required this.hasComment,
    required this.deleted,
    required this.likes,
    required this.hasLike,
    required this.files,
    required this.wasPremiumUser,
    required this.emphasizePremiumUserPost,
  });

  /// Create a PostModel object from a snapshot of a document.
  factory PostModel.fromSnapshot(DocumentSnapshot snapshot) {
    return PostModel.fromJson(
      snapshot.data() as Map<String, dynamic>,
      id: snapshot.id,
    );
  }

  /// Create a PostModel object from a json object.
  factory PostModel.fromJson(
    Map<String, dynamic> json, {
    String? id,
  }) {
    return PostModel(
      category: json['category'],
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      userDocumentReference: json['userDocumentReference'],
      createdAt: json['createdAt'] ?? Timestamp.now(),
      updatedAt: json['updatedAt'] ?? json['createdAt'],
      hasPhoto: json['hasPhoto'] ?? false,
      noOfComments: json['noOfComments'] ?? 0,
      hasComment: json['hasComment'] ?? false,
      deleted: json['deleted'] ?? false,
      likes: json['likes'] ?? [],
      hasLike: json['hasLike'] ?? false,
      files: json['files'] ?? [],
      wasPremiumUser: json['wasPremiumUser'] ?? false,
      emphasizePremiumUserPost: json['emphasizePremiumUserPost'] ?? false,
    );
  }

  // create "toString()" method that returns a string of the object of this class
  @override
  String toString() {
    return 'PostModel{ category: $category, title: $title, content: $content, userDocumentReference: $userDocumentReference, createdAt: $createdAt, updatedAt: $updatedAt, hasPhoto: $hasPhoto, noOfComments: $noOfComments, hasComment: $hasComment, deleted: $deleted, likes: $likes, hasLike: $hasLike, files: $files, wasPremiumUser: $wasPremiumUser, emphasizePremiumUserPost: $emphasizePremiumUserPost}';
  }
}
