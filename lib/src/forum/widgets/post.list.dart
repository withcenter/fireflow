import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';
import 'package:provider/provider.dart';

/// 글 목록 위젯
///
/// 글이 탭 되면, [onTap] 콜백이 지정되었으면 [onTap] 이 호출한다. 아니면, 기본 디자인 Dialog 화면으로 글 내용을 보여준다.
///
class PostList extends StatefulWidget {
  const PostList({
    super.key,
    this.categoryId,
    this.onTap,
  });

  final String? categoryId;
  final void Function(PostModel)? onTap;

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  void initState() {
    super.initState();
    //
  }

  Query get query {
    Query q = PostService.instance.col;
    if (widget.categoryId != null) {
      q = q.where('categoryId', isEqualTo: widget.categoryId);
    }
    // q = q.where('deleted', isEqualTo: false);
    q = q.orderBy('createdAt', descending: true);
    return q;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.blue,
          child: SafeArea(
            bottom: false,
            child: Row(
              children: [
                IconButton(
                  onPressed: Navigator.of(context).pop,
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                ),
                const Text('글 목록'),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: showPostCreateDialog,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: PaginateFirestore(
            itemBuilder: (context, documentSnapshots, index) {
              final snapshot = documentSnapshots[index];
              final post = PostModel.fromSnapshot(snapshot);
              return PostTile(
                post: post,
                onTap: (p) => widget.onTap != null
                    ? widget.onTap!(post)
                    : showPostViewDialog(context, p),
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

  /// 글 생성에 필요한 전체 기능을 가진 화면을 보여준다.
  void showPostCreateDialog() {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, a, b) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back)),
            title: const Text('Post Create'),
          ),
          body: SingleChildScrollView(
            child: PostCreate(
              categoryId: widget.categoryId,
              onCreated: (post) {
                Navigator.of(context).pop();
              },
            ),
          ),
        );
      },
    );
  }

  /// 글 읽기에 필요한 전체 기능을 가진 화면을 보여준다.
  /// 글 수정, 삭제 부터 시작해서 모든 기능의 버튼을 다 포함한다.
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
          appBar: AppBar(
            title: Text(post.title),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: PostView(
                post: post,
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
