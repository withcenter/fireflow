import 'package:cloud_firestore/cloud_firestore.dart';

class FeedModel {
  DocumentReference postDocumentReference;
  Timestamp createdAt;
  String title;
  String content;
  String? photoUrl;

  FeedModel({
    required this.postDocumentReference,
    required this.createdAt,
    required this.title,
    required this.content,
    this.photoUrl,
  });

  factory FeedModel.fromJson(Map<String, dynamic> json) {
    return FeedModel(
      postDocumentReference: json['postDocumentReference'],
      createdAt: json['createdAt'],
      title: json['title'],
      content: json['content'],
      photoUrl: json['photoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postDocumentReference': postDocumentReference,
      'createdAt': createdAt,
      'title': title,
      'content': content,
      if (photoUrl != null) 'photoUrl': photoUrl,
    };
  }
}
