import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';

/// Chat message model
class ChatRoomMessageModel {
  ChatRoomMessageModel(
      {required this.userDocumentReference,
      required this.chatRoomDocumentReference,
      required this.text,
      required this.sentAt,
      required this.ref,
      required this.uploadUrl,
      required this.uploadUrlType,
      required this.protocol,
      required this.protocolTargetUserDocumentReference,
      required this.previewUrl,
      required this.previewTitle,
      required this.previewDescription,
      required this.previewImageUrl});

  final DocumentReference userDocumentReference;
  final DocumentReference chatRoomDocumentReference;
  final String text;
  final String uploadUrl;
  final String uploadUrlType;
  final Timestamp sentAt;
  final String protocol;
  final DocumentReference? protocolTargetUserDocumentReference;

  final String previewUrl;
  final String previewTitle;
  final String previewDescription;
  final String previewImageUrl;

  final DocumentReference ref;

  /// Check if the message sent by me
  bool get isMine => userDocumentReference == UserService.instance.ref;

  bool get isProtocol => protocol.isNotEmpty;

  /// Create a ChatRoomMessageModel object from a snapshot
  factory ChatRoomMessageModel.fromSnapshot(DocumentSnapshot snapshot) {
    final json = snapshot.data() as Map<String, dynamic>;
    return ChatRoomMessageModel(
      userDocumentReference: json['userDocumentReference'],
      chatRoomDocumentReference: json['chatRoomDocumentReference'],
      text: json['text'] ?? "",

      /// For creation, the server timestamp is null on local cache.
      sentAt: json['sentAt'] ?? Timestamp.now(),
      ref: snapshot.reference,
      uploadUrl: json['uploadUrl'] ?? "",
      uploadUrlType: json['uploadUrlType'] ?? "",
      protocol: json['protocol'] ?? "",
      protocolTargetUserDocumentReference:
          json['protocolTargetUserDocumentReference'],
      previewUrl: json['previewUrl'] ?? "",
      previewTitle: json['previewTitle'] ?? "",
      previewDescription: json['previewDescription'] ?? "",
      previewImageUrl: json['previewImageUrl'] ?? "",
    );
  }

  /// Create a map data from ChatRoomMessageModel object
  Map<String, dynamic> get data {
    return {
      'userDocumentReference': userDocumentReference,
      'chatRoomDocumentReference': chatRoomDocumentReference,
      'text': text,
      'uploadUrl': uploadUrl,
      'uploadUrlType': uploadUrlType,
      'sentAt': sentAt,
      'protocol': protocol,
      'protocolTargetUserDocumentReference':
          protocolTargetUserDocumentReference,
      'previewUrl': previewUrl,
      'previewTitle': previewTitle,
      'previewDescription': previewDescription,
      'previewImageUrl': previewImageUrl,
    };
  }
}
