import 'package:cloud_firestore/cloud_firestore.dart';

/// SettingModel is a class that represents a document of /settings.
///
class SettingModel {
  DocumentReference userDocumentReference;

  SettingModel({
    required this.userDocumentReference,
  });

  factory SettingModel.fromSnapshot(DocumentSnapshot snapshot) {
    return SettingModel.fromJson(
      snapshot.data() as Map<String, dynamic>,
      id: snapshot.id,
    );
  }

  factory SettingModel.fromJson(
    Map<String, dynamic> json, {
    String? id,
  }) {
    return SettingModel(
      userDocumentReference: json['userDocumentReference'],
    );
  }

  // create "toString()" method that returns a string of the object of this class
  @override
  String toString() {
    return 'SettingModel{ userDocumentReference: $userDocumentReference}';
  }
}
