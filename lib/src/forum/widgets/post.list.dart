import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:fireflow/src/user/widgets/other_doc.dart';
import 'package:flutter/material.dart';

/// 글 목록 위젯
///
/// 새로운 글이 있어도 자동으로 갱신되지 않는다.
///
class PostList extends StatefulWidget {
  const PostList({
    super.key,
    this.categoryId,
    required this.onTap,
  });

  final String? categoryId;
  final void Function(PostModel) onTap;

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  Query get query {
    Query q = PostService.instance.col;
    if (widget.categoryId != null) {
      q = q.where('categoryId', isEqualTo: widget.categoryId);
    }
    q = q.orderBy('createdAt', descending: true);
    return q;
  }

  @override
  Widget build(BuildContext context) {
    return FirestoreListView(
      query: query,
      itemBuilder: (context, snapshot) {
        final post = PostModel.fromSnapshot(snapshot);
        return ListTile(
          title: Text(post.title),
          subtitle: Row(
            children: [
              Text(post.createdAt.toDate().toString()),
              const SizedBox(width: 8),
              OtherDoc(
                otherUserDocumentReference: post.userDocumentReference,
                builder: (user) {
                  return Text(user.displayName);
                },
              ),
            ],
          ),
          onTap: () => widget.onTap(post),
        );
      },
    );
  }
}
