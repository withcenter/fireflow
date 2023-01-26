import 'package:cloud_firestore/cloud_firestore.dart';

/// SystemSettingModel is a class that represents a document of /settings.
///
class SystemSettingModel {
  final String id;
  final Map<String, dynamic> data;

  SystemSettingModel({
    required this.id,
    required this.data,
  });

  /// Create a SystemSettingModel object from a snapshot of a document.
  factory SystemSettingModel.fromSnapshot(DocumentSnapshot snapshot) {
    return SystemSettingModel.fromJson(
      snapshot.data() as Map<String, dynamic>,
      id: snapshot.id,
    );
  }

  /// Create a SystemSettingModel object from a json object.
  factory SystemSettingModel.fromJson(
    Map<String, dynamic> json, {
    required String id,
  }) {
    return SystemSettingModel(
      id: id,
      data: json,
    );
  }

  // create "toString()" method that returns a string of the object of this class
  @override
  String toString() {
    return 'SystemSettingModel{ id: $id, data: $data }';
  }
}
