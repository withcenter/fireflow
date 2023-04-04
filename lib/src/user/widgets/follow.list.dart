import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

class FollowList extends StatelessWidget {
  const FollowList({
    super.key,
    this.onTap,
  });

  final void Function(UserModel)? onTap;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (final ref in my.followings)
          UserSticker(
            reference: ref,
            onTap: (user) => onTap != null
                ? onTap!(user)
                : showUserPublicProfileDialog(context, user),
          ),
      ],
    );
  }
}
