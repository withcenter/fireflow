import 'package:cloud_firestore/cloud_firestore.dart';

/// KeyModel is a class that represents a document of /chat_rooms.
///
class KeyModel {
  final String openAiApiKey;
  KeyModel({
    required this.openAiApiKey,
  });

  factory KeyModel.fromSnapshot(DocumentSnapshot snapshot) {
    return KeyModel.fromJson(
      snapshot.data() as Map<String, dynamic>,
      id: snapshot.id,
    );
  }

  factory KeyModel.fromJson(
    Map<String, dynamic> json, {
    String? id,
  }) {
    return KeyModel(
      openAiApiKey: json['openAiApiKey'] ?? '',
    );
  }

  // create "toString()" method that returns a string of the object of this class
  @override
  String toString() {
    return 'KeyModel{openAiApiKey: $openAiApiKey}';
  }
}
