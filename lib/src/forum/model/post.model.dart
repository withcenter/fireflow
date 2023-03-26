import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';

/// PostModel is a class that represents a document of /posts.
///
class PostModel {
  final String id;
  final String categoryId;
  final DocumentReference userDocumentReference;
  final String title;
  final String safeTitle;
  final String content;
  final String safeContent;
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

  final DocumentReference reference;

  PostModel({
    required this.reference,
    required this.id,
    required this.categoryId,
    required this.title,
    required this.safeTitle,
    required this.content,
    required this.safeContent,
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
    required String id,
  }) {
    /// Note that, on Firestore cache, the Timestamp on local cache would be null.
    return PostModel(
      reference: PostService.instance.doc(id),
      id: id,
      categoryId: json['categoryId'],
      title: json['title'] ?? '',
      safeTitle: safeString(json['title']),
      content: json['content'] ?? '',
      safeContent: safeString(json['content']),
      userDocumentReference: json['userDocumentReference'],
      createdAt: json['createdAt'] ?? Timestamp.now(),
      updatedAt: json['updatedAt'] ?? Timestamp.now(),
      hasPhoto: json['hasPhoto'] ?? false,
      noOfComments: json['noOfComments'] ?? 0,
      hasComment: json['hasComment'] ?? false,
      deleted: json['deleted'] ?? false,
      likes: List<DocumentReference>.from(json['likes'] ?? []),
      hasLike: json['hasLike'] ?? false,
      files: List<String>.from(json['files'] ?? []),
      wasPremiumUser: json['wasPremiumUser'] ?? false,
      emphasizePremiumUserPost: json['emphasizePremiumUserPost'] ?? false,
    );
  }

  // create "toString()" method that returns a string of the object of this class
  @override
  String toString() {
    return 'PostModel{ id: $id, categoryId: $categoryId, title: $title, content: $content, userDocumentReference: $userDocumentReference, createdAt: $createdAt, updatedAt: $updatedAt, hasPhoto: $hasPhoto, noOfComments: $noOfComments, hasComment: $hasComment, deleted: $deleted, likes: $likes, hasLike: $hasLike, files: $files, wasPremiumUser: $wasPremiumUser, emphasizePremiumUserPost: $emphasizePremiumUserPost}';
  }

  /// increase noOfComments by 1.
  ///
  /// This method is used when a new comment is created.
  Future increaseNoOfComment() =>
      reference.update({'noOfComments': FieldValue.increment(1)});

  /// 글 생성을 위한 기본 Map<String, dynamic> 객체를 생성한다.
  ///
  /// 직접 Map 을 작성하면 오타가 발생 할 수 있기 때문에 안전하게 생성한다.
  static Map<String, dynamic> toCreate({
    required String categoryId,
    required String title,
    required String content,
    List<String>? files,
    bool? hasPhoto,
    int? noOfComments,
    bool? hasComment,
    bool? deleted,
    List<DocumentReference>? likes,
    bool? hasLike,
    bool? wasPremiumUser,
    bool? emphasizePremiumUserPost,
  }) {
    return {
      'categoryId': categoryId,
      'title': title,
      'content': content,
      'userDocumentReference': UserService.instance.ref,
      'createdAt': FieldValue.serverTimestamp(),
      if (files != null) 'files': files,
      if (hasPhoto != null) 'hasPhoto': hasPhoto,
      if (noOfComments != null) 'noOfComments': noOfComments,
      if (hasComment != null) 'hasComment': hasComment,
      if (deleted != null) 'deleted': deleted,
      if (likes != null) 'likes': likes,
      if (hasLike != null) 'hasLike': hasLike,
      if (wasPremiumUser != null) 'wasPremiumUser': wasPremiumUser,
      if (emphasizePremiumUserPost != null)
        'emphasizePremiumUserPost': emphasizePremiumUserPost,
    };
  }

  /// 글 수정을 위한 Map<String, dynamic> 객체를 생성한다.
  ///
  /// 직접 Map 을 작성하면 오타가 발생 할 수 있기 때문에 안전하게 생성한다.
  static Map<String, dynamic> toUpdate({
    required DocumentReference postDocumentReference,
    String? title,
    String? content,
    List<String>? files,
    bool? hasPhoto,
    int? noOfComments,
    bool? hasComment,
    bool? deleted,
    List<DocumentReference>? likes,
    bool? hasLike,
    bool? wasPremiumUser,
    bool? emphasizePremiumUserPost,
  }) {
    return {
      'postId': postDocumentReference.id,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      'updatedAt': FieldValue.serverTimestamp(),
      if (files != null) 'files': files,
      if (hasPhoto != null) 'hasPhoto': hasPhoto,
      if (noOfComments != null) 'noOfComments': noOfComments,
      if (hasComment != null) 'hasComment': hasComment,
      if (deleted != null) 'deleted': deleted,
      if (likes != null) 'likes': likes,
      if (hasLike != null) 'hasLike': hasLike,
      if (wasPremiumUser != null) 'wasPremiumUser': wasPremiumUser,
      if (emphasizePremiumUserPost != null)
        'emphasizePremiumUserPost': emphasizePremiumUserPost,
    };
  }
}
