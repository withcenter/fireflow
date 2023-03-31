import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';

/// 글 목록 위젯
///
/// 글이 탭 되면, [onTap] 콜백이 지정되었으면 [onTap] 이 호출한다. 아니면, 기본 디자인 Dialog 화면으로 글 내용을 보여준다.
///
class PostList extends StatelessWidget {
  const PostList({
    super.key,
    this.categoryId,
    this.onTap,
  });

  final String? categoryId;
  final void Function(PostModel)? onTap;

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
          onTap: (p) =>
              onTap != null ? onTap!(post) : showPostViewDialog(context, p),
        );
      },
      query: query,
      itemBuilderType: PaginateBuilderType.listView,
      isLive: true,
    );
  }

  void showPostViewDialog(BuildContext context, PostModel post) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: PostView(
                post: post!,
                onDelete: (post) {
                  Navigator.of(context).pop();
                },
                onEdit: (post) {
                  //
                  print('edit post: ${post.id}');
                },
              ),
            ),
          ),
        );
      },
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
