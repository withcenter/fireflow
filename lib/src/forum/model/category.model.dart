import 'package:cloud_firestore/cloud_firestore.dart';

/// Category Model
///
/// CategoryModel is a class that represents a document of /categories.
///
class CategoryModel {
  final DocumentReference reference;
  final String id;
  final String categoryId;
  final String title;
  final int noOfPosts;
  final int noOfComments;

  /// 푸시 알림 구독 가능 여부. (현재는 필요 없음)
  final bool enablePushNotificationSubscription;

  /// 유료 회원이 작성한 글이면, 강조 표시하기
  final bool emphasizePremiumUserPost;

  /// 무료 회원, 다음 글 작성 대기 시간 (분)
  final int waitMinutesForNextPost;

  /// 유료 회원, 다음 글 작성 대기 시간 (분)
  final int waitMinutesForPremiumUserNextPost;

  CategoryModel({
    required this.reference,
    required this.id,
    required this.categoryId,
    required this.title,
    required this.noOfPosts,
    required this.noOfComments,
    required this.enablePushNotificationSubscription,
    required this.emphasizePremiumUserPost,
    required this.waitMinutesForNextPost,
    required this.waitMinutesForPremiumUserNextPost,
  });

  /// Create a CategoryModel object from a snapshot of a document.
  factory CategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    return CategoryModel.fromJson(
      snapshot.data() as Map<String, dynamic>,
      reference: snapshot.reference,
    );
  }

  /// Create a CategoryModel object from a json object.
  factory CategoryModel.fromJson(
    Map<String, dynamic> json, {
    required DocumentReference reference,
  }) {
    return CategoryModel(
      reference: reference,
      id: reference.id,
      categoryId: json['categoryId'],
      title: json['title'] ?? '',
      noOfPosts: json['noOfPosts'] ?? 0,
      noOfComments: json['noOfComments'] ?? 0,
      enablePushNotificationSubscription:
          json['enablePushNotificationSubscription'] ?? false,
      emphasizePremiumUserPost: json['emphasizePremiumUserPost'] ?? false,
      waitMinutesForNextPost: json['waitMinutesForNextPost'] ?? 0,
      waitMinutesForPremiumUserNextPost:
          json['waitMinutesForPremiumUserNextPost'] ?? 0,
    );
  }

  // create "toString()" method that returns a string of the object of this class
  @override
  String toString() {
    return 'CategoryModel{ categoryId: $categoryId, title: $title, noOfPosts: $noOfPosts, noOfComments: $noOfComments, enablePushNotificationSubscription: $enablePushNotificationSubscription, emphasizePremiumUserPost: $emphasizePremiumUserPost, waitMinutesForNextPost: $waitMinutesForNextPost, waitMinutesForPremiumUserNextPost: $waitMinutesForPremiumUserNextPost}';
  }

  /// increase noOfPosts by 1.
  ///
  /// This method is used when a new post is created.
  Future increaseNoOfPosts() =>
      reference.update({'noOfPosts': FieldValue.increment(1)});

  /// increase noOfComments by 1.
  ///
  /// This method is used when a new comment is created.
  Future increaseNoOfComment() =>
      reference.update({'noOfComments': FieldValue.increment(1)});

  static Map<String, dynamic> toUpdate({
    String? title,
    int? waitMinutesForNextPost,
    int? waitMinutesForPremiumUserNextPost,
    bool? emphasizePremiumUserPost,
  }) {
    return {
      if (title != null) 'title': title,
      if (waitMinutesForNextPost != null)
        'waitMinutesForNextPost': waitMinutesForNextPost,
      if (waitMinutesForPremiumUserNextPost != null)
        'waitMinutesForPremiumUserNextPost': waitMinutesForPremiumUserNextPost,
      if (emphasizePremiumUserPost != null)
        'emphasizePremiumUserPost': emphasizePremiumUserPost,
    };
  }
}
