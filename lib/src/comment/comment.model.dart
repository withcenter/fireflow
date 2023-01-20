import 'package:cloud_firestore/cloud_firestore.dart';

/// CommentModel is a class that represents a document of /comments.
///
class CommentModel {
  final DocumentReference postDocumentReference;
  final DocumentReference userDocumentReference;
  final String category;
  final String content;

  final Timestamp createdAt;

  CommentModel({
    required this.postDocumentReference,
    required this.userDocumentReference,
    required this.category,
    required this.content,
    required this.createdAt,
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
    String? id,
  }) {
    return CommentModel(
      postDocumentReference: json['postDocumentReference'],
      userDocumentReference: json['userDocumentReference'],
      category: json['category'] ?? '',
      content: json['content'] ?? '',
      createdAt: json['createdAt'] ?? Timestamp.now(),
    );
  }

  // create "toString()" method that returns a string of the object of this class
  @override
  String toString() {
    return 'CommentModel{postDocumentReference: $postDocumentReference, userDocumentReference: $userDocumentReference, category: $category, content: $content, createdAt: $createdAt}';
  }
}
