import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';

/// CategoryModel is a class that represents a document of /categories.
///
class CategoryModel {
  final String categoryId;
  final String title;
  final int noOfPosts;
  final int noOfComments;
  final bool enablePushNotificationSubscription;
  final bool emphasizePremiumUserPost;
  final int waitMinutesForNextPost;
  final int waitMinutesForPremiumUserNextPost;
  final DocumentReference ref;

  CategoryModel({
    required this.categoryId,
    required this.title,
    required this.noOfPosts,
    required this.noOfComments,
    required this.enablePushNotificationSubscription,
    required this.emphasizePremiumUserPost,
    required this.waitMinutesForNextPost,
    required this.waitMinutesForPremiumUserNextPost,
    required this.ref,
  });

  /// Create a CategoryModel object from a snapshot of a document.
  factory CategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    return CategoryModel.fromJson(
      snapshot.data() as Map<String, dynamic>,
      id: snapshot.id,
    );
  }

  /// Create a CategoryModel object from a json object.
  factory CategoryModel.fromJson(
    Map<String, dynamic> json, {
    String? id,
  }) {
    return CategoryModel(
      categoryId: json['categoryId'] ?? id,
      title: json['title'] ?? '',
      noOfPosts: json['noOfPosts'] ?? 0,
      noOfComments: json['noOfComments'] ?? 0,
      enablePushNotificationSubscription:
          json['enablePushNotificationSubscription'] ?? false,
      emphasizePremiumUserPost: json['emphasizePremiumUserPost'] ?? false,
      waitMinutesForNextPost: json['waitMinutesForNextPost'] ?? 0,
      waitMinutesForPremiumUserNextPost:
          json['waitMinutesForPremiumUserNextPost'] ?? 0,
      ref: CategoryService.instance.doc(json['categoryId'] ?? id),
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
      ref.update({'noOfPosts': FieldValue.increment(1)});

  /// increase noOfComments by 1.
  ///
  /// This method is used when a new comment is created.
  Future increaseNoOfComment() =>
      ref.update({'noOfComments': FieldValue.increment(1)});
}
