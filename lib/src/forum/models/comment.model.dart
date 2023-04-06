import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';

/// CommentModel is a class that represents a document of /comments.
///
class CommentModel {
  final DocumentReference reference;
  final String id;
  final DocumentReference postDocumentReference;
  final DocumentReference? parentCommentDocumentReference;
  final DocumentReference userDocumentReference;
  final String category;
  final String content;
  final String safeContent;
  final String order;
  final int depth;
  final bool deleted;
  final List<String> files;

  final Timestamp createdAt;
  final Timestamp updatedAt;

  CommentModel({
    required this.reference,
    required this.id,
    required this.postDocumentReference,
    required this.parentCommentDocumentReference,
    required this.userDocumentReference,
    required this.category,
    required this.content,
    required this.safeContent,
    required this.order,
    required this.depth,
    required this.createdAt,
    required this.updatedAt,
    required this.deleted,
    required this.files,
  });

  /// Create a CommentModel object from a snapshot of a document.
  factory CommentModel.fromSnapshot(DocumentSnapshot snapshot) {
    return CommentModel.fromJson(
      snapshot.data() as Map<String, dynamic>,
      reference: snapshot.reference,
    );
  }

  /// Create a CommentModel object from a json object.
  factory CommentModel.fromJson(
    Map<String, dynamic> json, {
    required DocumentReference reference,
  }) {
    return CommentModel(
      reference: reference,
      id: reference.id,
      postDocumentReference: json['postDocumentReference'],
      parentCommentDocumentReference: json['parentCommentDocumentReference'],
      userDocumentReference: json['userDocumentReference'],
      category: json['category'] ?? '',
      content: json['content'] ?? '',
      safeContent: safeString(json['content']),
      order: json['order'] ?? '',
      depth: json['depth'] ?? 0,
      deleted: json['deleted'] ?? false,
      files: List<String>.from(json['files'] ?? []),
      createdAt: json['createdAt'] ?? Timestamp.now(),
      updatedAt: json['updatedAt'] ?? Timestamp.now(),
    );
  }

  // create "toString()" method that returns a string of the object of this class
  @override
  String toString() {
    return 'CommentModel{ postDocumentReference: $postDocumentReference, parentCommentDocumentReference: $parentCommentDocumentReference, userDocumentReference: $userDocumentReference, category: $category, content: $content, order: $order, depth: $depth, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  /// 코멘트 생성을 위한 reference
  ///
  /// [reference] 는 자기 자신을 가르키는 reference 이다.
  ///
  ///
  /// TODO 함수명을 createCommentData() 로 변경하고, 글로벌 함수로 뺄 것.
  static Map<String, dynamic> toCreate({
    required DocumentReference postDocumentReference,
    // DocumentReference? parentCommentDocumentReference,
    required DocumentReference userDocumentReference,
    required DocumentReference reference,
    String? content,
    String? parentOrder,
    int? parentDepth,
    int? postNoOfComment,
  }) {
    return {
      'reference': reference,
      'postDocumentReference': postDocumentReference,
      // 'parentCommentDocumentReference': parentCommentDocumentReference,
      'userDocumentReference': userDocumentReference,
      'content': content ?? '',
      'createdAt': FieldValue.serverTimestamp(),
      'order': commentOrder(parentOrder, parentDepth, postNoOfComment),
      'depth': (parentDepth ?? 0) + 1,
    };
  }
}
