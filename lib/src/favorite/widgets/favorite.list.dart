import 'package:fireflow/fireflow.dart';
import 'package:fireflow/src/favorite/widgets/favorite.list.post.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';

class FavoriteList extends StatelessWidget {
  const FavoriteList({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginateFirestore(
      itemBuilder: (context, snapshots, index) {
        final favorite = FavoriteModel.fromSnapshot(snapshots[index]);

        /// 글 즐겨찾기
        if (favorite.type == FavoriteType.posts.name) {
          return FavoritePostTile(
            postDocumentReference: favorite.targetDocumentReference,
          );

          /// 코멘트 즐겨찾기
        } else if (favorite.type == FavoriteType.comments.name) {
          return Row(
            children: [
              Text(
                favorite.targetDocumentReference.path,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const SizedBox(width: 10),
              Text(favorite.createdAt.toString()),
            ],
          );

          /// 사용자 즐겨찾기
        } else if (favorite.type == FavoriteType.users.name) {
          return UserSticker(
            reference: favorite.targetDocumentReference,
            onTap: (user) => showUserPublicProfileDialog(context, user),

            // Navigator.of(context).pushNamed(
            //   '/user/${user.reference.id}',
            // ),
            trailing: const Icon(Icons.chevron_right),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
      query: FavoriteService.instance.myFavorites,
      itemBuilderType: PaginateBuilderType.listView,
      onEmpty: EmptyList(title: ln('no_item_in_favorite_list')),
      isLive: true,
    );
  }
}
