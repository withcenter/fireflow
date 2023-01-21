import 'package:cloud_firestore/cloud_firestore.dart';

/// UserSettingModel is a class that represents a document of /settings.
///
class UserSettingModel {
  final String id;
  final DocumentReference userDocumentReference;
  final bool notifyNewComments;

  UserSettingModel({
    required this.id,
    required this.userDocumentReference,
    required this.notifyNewComments,
  });

  /// Create a UserSettingModel object from a snapshot of a document.
  factory UserSettingModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserSettingModel.fromJson(
      snapshot.data() as Map<String, dynamic>,
      id: snapshot.id,
    );
  }

  /// Create a UserSettingModel object from a json object.
  factory UserSettingModel.fromJson(
    Map<String, dynamic> json, {
    required String id,
  }) {
    return UserSettingModel(
      id: id,
      userDocumentReference: json['userDocumentReference'],
      notifyNewComments: json['notifyNewComments'] ?? false,
    );
  }

  // create "toString()" method that returns a string of the object of this class
  @override
  String toString() {
    return 'UserSettingModel{ id: $id, userDocumentReference: $userDocumentReference, notifyNewComments: $notifyNewComments }';
  }
}
