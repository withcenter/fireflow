
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

/// 다른 사용자의 공개 문서를 listen 한다.
///
///
class UserDoc extends StatefulWidget {
  const UserDoc({Key? key, required this.reference, required this.builder})
      : super(key: key);

  final DocumentReference reference;
  final Widget Function(UserModel other) builder;

  @override
  State<UserDoc> createState() => _UserDocState();
}

class _UserDocState extends State<UserDoc> {
  UserModel? user;
  @override
  void initState() {
    super.initState();
    widget.reference.snapshots().listen((doc) {
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
