import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

/// 다른 사용자의 공개 문서를 listen 한다.
///
///
class OtherDoc extends StatefulWidget {
  const OtherDoc(
      {Key? key,
      required this.otherUserDocumentReference,
      required this.builder})
      : super(key: key);

  final DocumentReference otherUserDocumentReference;
  final Widget Function(UserModel other) builder;

  @override
  State<OtherDoc> createState() => _OtherDocState();
}

class _OtherDocState extends State<OtherDoc> {
  UserModel? user;
  @override
  void initState() {
    super.initState();
    widget.otherUserDocumentReference.snapshots().listen((doc) {
      if (mounted) {
        setState(() {
          user = UserModel.fromSnapshot(doc);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return user == null ? const SizedBox.shrink() : widget.builder(user!);
  }
}
