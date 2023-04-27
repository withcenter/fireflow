import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';

/// 글 목록 위젯
///
/// 글이 탭 되면, [onTap] 콜백이 지정되었으면 [onTap] 이 호출한다. 아니면, 기본 디자인 Dialog 화면으로 글 내용을 보여준다.
///
///
/// TODO 카테고리 메뉴를 커스텀 디자인으로 만들면, 카테고리 메뉴가 깜박거리는데, 이 문제를 해결 해야 한다.
class PostList extends StatefulWidget {
  const PostList({
    super.key,
    this.categoryId,
    this.onTap,
    // this.onChat, // 채팅 기능 일시 보류. 채팅에 너무 많은 문서 access 가 발생해, firestore 에서 realtime database 로 수정해야 한다.
    this.headerBuilder,
    this.categoryMenuBuilder,
    this.itemBuilder,
  });

  final String? categoryId;

  /// 게시글을 클릭 했을 때, 호출되는 콜백. 기본 디자인을 사용하는 경우에만 호출된다.
  final void Function(PostModel)? onTap;
  // final void Function(UserModel)? onChat;

  final Widget Function(String? categoryId)? headerBuilder;
  final Widget Function(String? currentCategoryId)? categoryMenuBuilder;

  /// 목록에 표시할 각 게시글의 위젯을 만드는 빌더 콜백. FF 에서 쓰기 쉽도록 DocumentSnapshot 을 넘겨준다.
  final Widget Function(DocumentSnapshot post)? itemBuilder;

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  /// 현재 선택된 카테고리
  String? currentCategoryId;

  @override
  void initState() {
    super.initState();

    currentCategoryId = widget.categoryId;
  }

  Query get query {
    Query q = PostService.instance.col;
    if (currentCategoryId != null) {
      q = q.where('categoryId', isEqualTo: currentCategoryId);
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
            ? widget.headerBuilder!(currentCategoryId)
            : PostListHeader(categoryId: currentCategoryId),

        widget.categoryMenuBuilder != null
            ? widget.categoryMenuBuilder!(currentCategoryId)
            : PostListCategories(
                onTap: (String? id) =>
                    setState(() => currentCategoryId = (id == '') ? null : id),
              ),

        /// 게시글 목록
        Expanded(
          child: PaginateFirestore(
            key: ValueKey('categoryId${currentCategoryId ?? ''}'),
            itemBuilder: (context, documentSnapshots, index) {
              final snapshot = documentSnapshots[index];
              final post = PostModel.fromSnapshot(snapshot);
              if (widget.itemBuilder != null) {
                return widget.itemBuilder!(snapshot);
              }
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
