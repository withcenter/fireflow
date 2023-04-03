import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

/// 카테고리 수정 위젯
///
/// 수정/삭제 및 취소 버튼을 누르면 필요한 코드를 실행하고, 부모 위젯의 콜백 함수를 호출한다.
/// 콜백 함수에서 페이지 이동 등을 하면 된다.
class CategoryEdit extends StatefulWidget {
  const CategoryEdit({
    super.key,
    required this.categoryDocumentReference,
    required this.onCancel,
    required this.onDelete,
    required this.onEdit,
  });

  final DocumentReference categoryDocumentReference;
  final void Function(DocumentReference) onCancel;
  final void Function(DocumentReference) onDelete;
  final void Function(DocumentReference) onEdit;

  @override
  State<CategoryEdit> createState() => _CategoryEditState();
}

class _CategoryEditState extends State<CategoryEdit> {
  final CategoryModel? category = null;

  final titleController = TextEditingController();

  final waitMinutesForNextPostController = TextEditingController();
  final waitMinutesForPremiumUserNextPostController = TextEditingController();

  bool emphasizePremiumUserPost = false;
  bool displayCategoryInForm = false;
  bool displayCategoryOnListMenu = false;
  bool readOnly = false;

  @override
  void initState() {
    super.initState();
    CategoryService.instance
        .get(categoryDocumentReference: widget.categoryDocumentReference)
        .then((category) {
      setState(() {
        category = category;

        titleController.text = category.title;
        waitMinutesForNextPostController.text =
            category.waitMinutesForNextPost.toString();
        waitMinutesForPremiumUserNextPostController.text =
            category.waitMinutesForPremiumUserNextPost.toString();
        emphasizePremiumUserPost = category.emphasizePremiumUserPost;
        displayCategoryInForm = category.displayCategoryInForm;
        displayCategoryOnListMenu = category.displayCategoryOnListMenu;
        readOnly = category.readOnly;
      });
    });

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   if (my.admin == false) {
    //     warning(context, 'You are not admin.');
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text('Category ID'),
        const SizedBox(height: 10),
        Text(widget.categoryDocumentReference.id),
        const SizedBox(height: 24),
        const Text('Input category title'),
        const SizedBox(height: 10),
        TextField(
          controller: titleController,
          decoration: const InputDecoration(
            hintText: 'Category Title',
            label: Text('Category Title'),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 24),
        const Text('How many minutes to wait for next post for normal user'),
        const SizedBox(height: 10),
        TextField(
          controller: waitMinutesForNextPostController,
          decoration: const InputDecoration(
            hintText: 'Input integer of minutes',
            label: Text('Wait Minutes For Next Post'),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 24),
        const Text('How many minutes to wait for next post for premium user'),
        const SizedBox(height: 10),
        TextField(
          controller: waitMinutesForPremiumUserNextPostController,
          decoration: const InputDecoration(
            hintText: 'Input integer of minutes',
            label: Text('Wait Minutes For Permium User Next Post'),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 24),
        const Text('Emphasize posts for permium users'),
        const SizedBox(height: 10),

        // 프리미엄 유저 글 강조 표시
        SwitchListTile(
          title: const Text('Emphasize posts for permium users'),
          value: emphasizePremiumUserPost,
          onChanged: (value) {
            setState(() {
              emphasizePremiumUserPost = value;
            });
          },
        ),

        // 글 쓰기/수정 페이지에 카테고리 선택 위젯에 표시
        SwitchListTile(
          title: const Text('Display category on post form'),
          value: displayCategoryInForm,
          onChanged: (value) {
            setState(() {
              displayCategoryInForm = value;
            });
          },
        ),

        // 글 목록 페이지 상단 메뉴에 카테고리 표시
        SwitchListTile(
          title: const Text('Display category on post list menu'),
          value: displayCategoryOnListMenu,
          onChanged: (value) {
            setState(() {
              displayCategoryOnListMenu = value;
            });
          },
        ),

        // 관리자 전용 글 쓰기
        SwitchListTile(
          title: const Text('Admin only post create'),
          value: readOnly,
          onChanged: (value) {
            setState(() {
              readOnly = value;
            });
          },
        ),

        Row(
          children: [
            TextButton(
              onPressed: () async {
                final re = await confirm(
                  context,
                  'Delete Category',
                  'Are you sure to delete this category?',
                );
                if (re == false) return;
                await CategoryService.instance.delete(
                  categoryDocumentReference: widget.categoryDocumentReference,
                );
                widget.onDelete(widget.categoryDocumentReference);
              },
              child: const Text(
                'DELETE',
                style: TextStyle(color: Colors.red),
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () =>
                  widget.onCancel(widget.categoryDocumentReference),
              child: const Text('CANCEL'),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () async {
                await CategoryService.instance.update(
                  categoryDocumentReference: widget.categoryDocumentReference,
                  title: titleController.text,
                  waitMinutesForNextPost:
                      int.tryParse(waitMinutesForNextPostController.text) ?? 0,
                  waitMinutesForPremiumUserNextPost: int.tryParse(
                          waitMinutesForPremiumUserNextPostController.text) ??
                      0,
                  emphasizePremiumUserPost: emphasizePremiumUserPost,
                  displayCategoryInForm: displayCategoryInForm,
                  displayCategoryOnListMenu: displayCategoryOnListMenu,
                  readOnly: readOnly,
                );
                widget.onEdit(widget.categoryDocumentReference);
              },
              child: const Text('EDIT'),
            ),
          ],
        ),
      ],
    );
  }
}
