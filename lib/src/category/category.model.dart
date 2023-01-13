import 'package:cloud_firestore/cloud_firestore.dart';

/// CategoryModel is a class that represents a document of /categories.
///
class CategoryModel {
  final String category;
  final String title;
  final int noOfPosts;
  final int noOfComments;
  final bool enablePushNotificationSubscription;
  final bool emphasizePremiumUserPost;
  final int waitMinutesForNextPost;
  final int waitMinutesForPremiumUserNextPost;

  CategoryModel({
    required this.category,
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
      id: snapshot.id,
    );
  }

  /// Create a CategoryModel object from a json object.
  factory CategoryModel.fromJson(
    Map<String, dynamic> json, {
    String? id,
  }) {
    return CategoryModel(
      category: json['category'],
      title: json['title'] ?? '',
      noOfPosts: json['noOfPosts'] ?? 0,
      noOfComments: json['noOfComments'] ?? 0,
      enablePushNotificationSubscription: json['enablePushNotificationSubscription'] ?? false,
      emphasizePremiumUserPost: json['emphasizePremiumUserPost'] ?? false,
      waitMinutesForNextPost: json['waitMinutesForNextPost'] ?? 0,
      waitMinutesForPremiumUserNextPost: json['waitMinutesForPremiumUserNextPost'] ?? 0,
    );
  }

  // create "toString()" method that returns a string of the object of this class
  @override
  String toString() {
    return 'CategoryModel{ category: $category, title: $title, noOfPosts: $noOfPosts, noOfComments: $noOfComments, enablePushNotificationSubscription: $enablePushNotificationSubscription, emphasizePremiumUserPost: $emphasizePremiumUserPost, waitMinutesForNextPost: $waitMinutesForNextPost, waitMinutesForPremiumUserNextPost: $waitMinutesForPremiumUserNextPost}';
  }
}
