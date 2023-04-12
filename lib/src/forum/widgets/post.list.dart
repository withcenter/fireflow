import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';

/// 글 목록 위젯
///
/// 글이 탭 되면, [onTap] 콜백이 지정되었으면 [onTap] 이 호출한다. 아니면, 기본 디자인 Dialog 화면으로 글 내용을 보여준다.
///
class PostList extends StatefulWidget {
  const PostList({
    super.key,
    this.categoryId,
    this.onTap,
    // this.onChat, // 채팅 기능 일시 보류. 채팅에 너무 많은 문서 access 가 발생해, firestore 에서 realtime database 로 수정해야 한다.
    this.headerBuilder,
  });

  final String? categoryId;
  final void Function(PostModel)? onTap;
  // final void Function(UserModel)? onChat;

  final Widget Function(String? categoryId)? headerBuilder;

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  String? categoryId;

  @override
  void initState() {
    super.initState();

    categoryId = widget.categoryId;
  }

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
    return Column(
      children: [
        widget.headerBuilder != null
            ? widget.headerBuilder!(categoryId)
            : PostListHeader(categoryId: categoryId),

        PostListCategories(
          onTap: (String? id) =>
              setState(() => categoryId = (id == '') ? null : id),
        ),

        /// 게시글 목록
        Expanded(
          child: PaginateFirestore(
            key: ValueKey('categoryId${categoryId ?? ''}'),
            itemBuilder: (context, documentSnapshots, index) {
              final snapshot = documentSnapshots[index];
              final post = PostModel.fromSnapshot(snapshot);
              return PostListTile(
                post: post,
                onTap: (p) => widget.onTap != null
                    ? widget.onTap!(post)
                    : showPostViewDialog(
                        context: context,
                        post: p,
                        // onChat: widget.onChat,
                      ),
              );
            },
            query: query,
            itemBuilderType: PaginateBuilderType.listView,
            isLive: true,
          ),
        ),
      ],
    );
  }
}
