import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

/// 다른 사용자의 공개 문서를 listen 한다.
///
///
class OtherDoc extends StatelessWidget {
  const OtherDoc(
      {Key? key,
      required this.otherUserDocumentReference,
      required this.builder})
      : super(key: key);

  final DocumentReference otherUserDocumentReference;
  final Widget Function(UserModel other) builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: otherUserDocumentReference.snapshots().map(
              (doc) => UserModel.fromSnapshot(doc),
            ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox.shrink();
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const SizedBox.shrink();
          }

          return builder(snapshot.data as UserModel);
        });
  }
}
