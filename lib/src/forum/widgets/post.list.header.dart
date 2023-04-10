import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

/// 게시 글 목록 헤더
///
/// 뒤로가기 버튼, 글 작성 버튼 등.
class PostListHeader extends StatelessWidget {
  const PostListHeader({
    super.key,
    required this.categoryId,
  });

  final String? categoryId;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              onPressed: () => showPostCreateDialog(
                context: context,
                categoryId: categoryId,
              ),
            ),
            if (my.admin)

              /// create popup menu button with settings icon and edit menu
              PopupMenuButton(
                icon: const Icon(Icons.settings),
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem(
                      value: 'category',
                      child: Text('Category Management'),
                    ),
                    // const PopupMenuItem(
                    //   value: 'delete',
                    //   child: Text('Delete'),
                    // ),
                  ];
                },
                onSelected: (value) {
                  if (value == 'category') {
                    showCategoryListDialog(context: context);
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}
