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
  });

  final String? categoryId;
  final void Function(PostModel)? onTap;

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
        /// 게시 글 목록 헤더
        ///
        /// 뒤로가기 버튼, 글 작성 버튼 등.
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

        /// 게시글 목록 상단 카테고리 목록
        ///
        /// 관리자 페이지에서 각 카테고리 별, 메뉴에 표시하기 설정을 하면 여기에 표시된다.
        /// 단, 메뉴에 표시하기로 선택된 카테고리가 하나도 없으면, 메뉴 자체가 나타나지 않고, 전체 카테고리가 표시된다.
        SizedBox(
          height: 60,
          child: FutureBuilder(
            future: CategoryService.instance.col
                .where('displayCategoryOnListMenu', isEqualTo: true)
                .get(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                final docs = snapshot.data!.docs;
                final Map<String, String> categories = {};
                categories[''] = '전체';
                for (final doc in docs) {
                  final category = CategoryModel.fromSnapshot(doc);
                  categories[category.id] = category.title;
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final id = categories.keys.elementAt(index);
                    final title = categories.values.elementAt(index);
                    return TextButton(
                      onPressed: () {
                        setState(() {
                          dog(id);
                          setState(() {
                            categoryId = (id == '') ? null : id;
                          });
                        });
                      },
                      child: Text(title),
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
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
              categoryId: categoryId,
              onCreated: (post) {
                Navigator.of(context).pop();
              },
            ),
          ),
        );
      },
    );
  }
}
