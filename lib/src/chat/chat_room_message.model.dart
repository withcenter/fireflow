import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';

/// Chat message model
class ChatRoomMessageModel {
  ChatRoomMessageModel({
    required this.userDocumentReference,
    required this.chatRoomDocumentReference,
    required this.text,
    required this.uploadUrl,
    required this.sentAt,
    required this.ref,
  });

  final DocumentReference userDocumentReference;
  final DocumentReference chatRoomDocumentReference;
  final String text;
  final String uploadUrl;
  final Timestamp sentAt;

  final DocumentReference ref;

  /// Check if the message sent by me
  bool get isMine => userDocumentReference == UserService.instance.ref;

  /// Create a ChatRoomMessageModel object from a snapshot
  factory ChatRoomMessageModel.fromSnapshot(DocumentSnapshot snapshot) {
    final json = snapshot.data() as Map<String, dynamic>;
    return ChatRoomMessageModel(
      userDocumentReference: json['userDocumentReference'],
      chatRoomDocumentReference: json['chatRoomDocumentReference'],
      text: json['text'] ?? "",
      uploadUrl: json['uploadUrl'] ?? "",

      /// For creation, the server timestamp is null on local cache.
      sentAt: json['sentAt'] ?? Timestamp.now(),
      ref: snapshot.reference,
    );
  }

  /// Create a map data from ChatRoomMessageModel object
  Map<String, dynamic> get data {
    return {
      'userDocumentReference': userDocumentReference,
      'chatRoomDocumentReference': chatRoomDocumentReference,
      'text': text,
      'uploadUrl': uploadUrl,
      'sentAt': sentAt,
    };
  }
}
