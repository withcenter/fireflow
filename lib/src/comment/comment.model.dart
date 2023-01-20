import 'package:cloud_firestore/cloud_firestore.dart';

/// CommentModel is a class that represents a document of /comments.
///
class CommentModel {
  final String id;
  final DocumentReference postDocumentReference;
  final DocumentReference? parentCommentDocumentReference;
  final DocumentReference userDocumentReference;
  final String category;
  final String content;
  final String order;
  final int depth;

  final Timestamp createdAt;
  final Timestamp updatedAt;

  CommentModel({
    required this.id,
    required this.postDocumentReference,
    required this.parentCommentDocumentReference,
    required this.userDocumentReference,
    required this.category,
    required this.content,
    required this.order,
    required this.depth,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Create a CommentModel object from a snapshot of a document.
  factory CommentModel.fromSnapshot(DocumentSnapshot snapshot) {
    return CommentModel.fromJson(
      snapshot.data() as Map<String, dynamic>,
      id: snapshot.id,
    );
  }

  /// Create a CommentModel object from a json object.
  factory CommentModel.fromJson(
    Map<String, dynamic> json, {
    required String id,
  }) {
    return CommentModel(
      id: id,
      postDocumentReference: json['postDocumentReference'],
      parentCommentDocumentReference: json['parentCommentDocumentReference'],
      userDocumentReference: json['userDocumentReference'],
      category: json['category'] ?? '',
      content: json['content'] ?? '',
      order: json['order'] ?? '',
      depth: json['depth'] ?? 0,
      createdAt: json['createdAt'] ?? Timestamp.now(),
      updatedAt: json['updatedAt'] ?? Timestamp.now(),
    );
  }

  // create "toString()" method that returns a string of the object of this class
  @override
  String toString() {
    return 'CommentModel{ postDocumentReference: $postDocumentReference, parentCommentDocumentReference: $parentCommentDocumentReference, userDocumentReference: $userDocumentReference, category: $category, content: $content, order: $order, depth: $depth, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
