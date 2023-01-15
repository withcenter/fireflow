import 'package:cloud_firestore/cloud_firestore.dart';

/// UserSettingModel is a class that represents a document of /settings.
///
class UserSettingModel {
  DocumentReference userDocumentReference;

  UserSettingModel({
    required this.userDocumentReference,
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
    String? id,
  }) {
    return UserSettingModel(
      userDocumentReference: json['userDocumentReference'],
    );
  }

  // create "toString()" method that returns a string of the object of this class
  @override
  String toString() {
    return 'UserSettingModel{ userDocumentReference: $userDocumentReference}';
  }
}
