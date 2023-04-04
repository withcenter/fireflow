import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

class BlockList extends StatelessWidget {
  const BlockList({
    super.key,
    this.onTap,
  });

  final void Function(UserModel)? onTap;

  @override
  Widget build(BuildContext context) {
    return MyDocStream(login: (_) {
      if (my.blockedUsers.isEmpty) {
        return EmptyList(
          title: ln('no_item_in_block_list'),
        );
      }
      return ListView(
        children: [
          for (final ref in my.blockedUsers)
            UserSticker(
              reference: ref,
              onTap: (user) => onTap != null
                  ? onTap!(user)
                  : showUserPublicProfileDialog(context, user),
            ),
        ],
      );
    });
  }
}
