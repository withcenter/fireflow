import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';

/// 글 목록 위젯
///
/// 새로운 글이 있어도 자동으로 갱신되지 않는다.
///
class PostList extends StatelessWidget {
  const PostList({
    super.key,
    this.categoryId,
    required this.onTap,
  });

  final String? categoryId;
  final void Function(PostModel) onTap;

  Query get query {
    Query q = PostService.instance.col;
    if (categoryId != null) {
      q = q.where('categoryId', isEqualTo: categoryId);
    }
    // q = q.where('deleted', isEqualTo: false);
    q = q.orderBy('createdAt', descending: true);
    return q;
  }

  @override
  Widget build(BuildContext context) {
    return PaginateFirestore(
      itemBuilder: (context, documentSnapshots, index) {
        final snapshot = documentSnapshots[index];
        final post = PostModel.fromSnapshot(snapshot);
        return PostTile(
          post: post,
          onTap: onTap,
        );
      },
      query: query,
      itemBuilderType: PaginateBuilderType.listView,
      isLive: true,
    );
  }
}

class PostTile extends StatelessWidget {
  const PostTile({
    super.key,
    required this.post,
    required this.onTap,
  });

  final PostModel post;
  final void Function(PostModel) onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(post.deleted ? Config.deletedPost : post.title),
      subtitle: Wrap(
        children: [
          Text(post.id),
          const SizedBox(width: 8),
          Text(post.deleted
              ? Config.deletedPost
              : post.createdAt.toDate().toString()),
          const SizedBox(width: 8),
          UserDoc(
            reference: post.userDocumentReference,
            builder: (user) {
              return Text(user.displayName);
            },
          ),
        ],
      ),
      onTap: () => onTap(post),
    );
  }
}
