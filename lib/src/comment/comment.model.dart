import 'package:cloud_firestore/cloud_firestore.dart';

/// CommentModel is a class that represents a document of /comments.
///
class CommentModel {
  final String category;
  final String comment;

  CommentModel({
    required this.category,
    required this.comment,
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
      category: json['category'],
      comment: json['comment'] ?? '',
    );
  }

  // create "toString()" method that returns a string of the object of this class
  @override
  String toString() {
    return 'CommentModel{ category: $category, comment: $comment}';
  }
}
