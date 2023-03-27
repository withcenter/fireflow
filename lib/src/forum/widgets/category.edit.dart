import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

class CategoryEdit extends StatefulWidget {
  const CategoryEdit({
    super.key,
    required this.categoryDocumentReference,
    required this.onDelete,
    required this.onEdit,
  });

  final DocumentReference categoryDocumentReference;
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
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (my.admin == false) {
        warning(context, 'You are not admin.');
      }
    });
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

// get swich list tile for emphasizePremiumUserPost
        SwitchListTile(
          title: const Text('Emphasize posts for permium users'),
          value: emphasizePremiumUserPost,
          onChanged: (value) {
            setState(() {
              emphasizePremiumUserPost = value;
            });
          },
        ),

        Row(
          children: [
            TextButton(
              onPressed: () async {
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
              onPressed: () {
                Navigator.of(context).pop();
              },
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
