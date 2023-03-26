import 'package:cloud_firestore/cloud_firestore.dart';

/// Category Model
///
/// CategoryModel is a class that represents a document of /categories.
///
class CategoryModel {
  final DocumentReference reference;
  final String categoryId;
  final String title;
  final int noOfPosts;
  final int noOfComments;
  final bool enablePushNotificationSubscription;
  final bool emphasizePremiumUserPost;
  final int waitMinutesForNextPost;
  final int waitMinutesForPremiumUserNextPost;

  CategoryModel({
    required this.reference,
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
      categoryId: reference.id,
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
}
