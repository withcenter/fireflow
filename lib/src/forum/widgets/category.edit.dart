import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

class CategoryEdit extends StatefulWidget {
  const CategoryEdit({
    super.key,
    required this.categoryDocumentReference,
    required this.onEdit,
  });

  final DocumentReference categoryDocumentReference;
  final void Function(DocumentReference) onEdit;

  @override
  State<CategoryEdit> createState() => _CategoryEditState();
}

class _CategoryEditState extends State<CategoryEdit> {
  final categoryIdController = TextEditingController();
  final titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    CategoryService.instance
        .get(categoryDocumentReference: widget.categoryDocumentReference)
        .then((category) {
      setState(() {
        categoryIdController.text = category.categoryId;
        titleController.text = category.title;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: CategoryService.instance.get(
        categoryDocumentReference: widget.categoryDocumentReference,
      ),
      builder: (context, snapshot) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text('Input category name'),
          const SizedBox(height: 10),
          TextField(
            controller: categoryIdController,
            decoration: const InputDecoration(
                hintText: 'Category ID',
                border: OutlineInputBorder(),
                label: Text('Category ID'),
                floatingLabelBehavior: FloatingLabelBehavior.always),
          ),
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
          ElevatedButton(
            onPressed: () async {
              final categoryDocumentReference =
                  await CategoryService.instance.create(
                categoryId: categoryIdController.text,
                title: titleController.text,
              );
              widget.onEdit(categoryDocumentReference);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
