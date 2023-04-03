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

        if (favorite.type == FavoriteType.posts.name) {
          return FavoritePostTile(
              postDocumentReference: favorite.targetDocumentReference);
        }

        return Row(
          children: [
            Text(favorite.targetDocumentReference.path),
            const SizedBox(width: 10),
            Text(favorite.createdAt.toString()),
          ],
        );
      },
      query: FavoriteService.instance.myFavorites,
      itemBuilderType: PaginateBuilderType.listView,
    );
  }
}
