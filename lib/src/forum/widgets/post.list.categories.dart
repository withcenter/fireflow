import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

/// 게시글 목록 상단 카테고리 목록
///
/// 관리자 페이지에서 각 카테고리 별, 메뉴에 표시하기 설정을 하면 여기에 표시된다.
/// 단, 메뉴에 표시하기로 선택된 카테고리가 하나도 없으면, 메뉴 자체가 나타나지 않고, 전체 카테고리가 표시된다.
class PostListCategories extends StatelessWidget {
  const PostListCategories({
    super.key,
    required this.onTap,
  });

  final void Function(String?) onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                  onPressed: () => onTap(id),
                  child: Text(title),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
