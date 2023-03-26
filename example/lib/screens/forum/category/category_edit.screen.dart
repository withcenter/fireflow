import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

class CategoryEditScreen extends StatefulWidget {
  const CategoryEditScreen({super.key, this.category});

  final String? category;

  @override
  State<CategoryEditScreen> createState() => _CategoryEditScreenState();
}

class _CategoryEditScreenState extends State<CategoryEditScreen> {
  final title = TextEditingController();
  final id = TextEditingController();

  CategoryModel? category;

  @override
  void initState() {
    super.initState();

    if (widget.category != null) {
      CategoryService.instance.col.doc(widget.category).get().then((value) {
        category = CategoryModel.fromSnapshot(value);
        title.text = category!.title;
        id.text = category!.categoryId;
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Category Edit')),
      body: Container(
        color: Colors.pink.shade50,
        child: Column(
          children: [
            TextField(
              controller: id,
              decoration: const InputDecoration(
                labelText: 'Category ID',
              ),
            ),
            TextField(
              controller: title,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                CategoryService.instance.col.doc(id.text).set({
                  'title': title.text,
                  'category': id.text,
                }, SetOptions(merge: true));
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
