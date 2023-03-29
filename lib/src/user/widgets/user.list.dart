import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';

class UserList extends StatelessWidget {
  const UserList({
    super.key,
    required this.onTap,
  });

  final void Function(UserModel) onTap;

  @override
  Widget build(BuildContext context) {
    return PaginateFirestore(
      itemBuilder: (context, documentSnapshots, index) {
        final user = UserModel.fromSnapshot(documentSnapshots[index]);
        return UserSticker(
          user: user,
          onTap: (user) => onTap(user),
        );
      },
      query: UserService.instance.col,
      itemBuilderType: PaginateBuilderType.listView,
    );
  }
}
