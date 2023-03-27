import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
    required this.onTap,
  });

  final void Function(DocumentReference categoryDocumentReference) onTap;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: CategoryService.instance.col.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}}'),
          );
        }

        if (!snapshot.hasData || snapshot.data!.size == 0) {
          return const Center(
            child: Text('No categories, yet'),
          );
        }

        return ListView.builder(
          itemBuilder: (context, index) {
            final category =
                CategoryModel.fromSnapshot(snapshot.data!.docs[index]);
            return ListTile(
              title: Text(category.title),
              subtitle: Text(category.categoryId),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () => onTap(category.reference),
            );
          },
          itemCount: snapshot.data!.size,
        );
      },
    );
  }
}
