import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

class CategoryCreate extends StatefulWidget {
  const CategoryCreate({
    super.key,
    required this.onCreated,
  });

  final void Function(DocumentReference) onCreated;

  @override
  State<CategoryCreate> createState() => _CategoryCreateState();
}

class _CategoryCreateState extends State<CategoryCreate> {
  final categoryIdController = TextEditingController();
  final titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
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
            widget.onCreated(categoryDocumentReference);
          },
          child: const Text('Created'),
        ),
      ],
    );
  }
}
