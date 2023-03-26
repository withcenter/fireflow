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

        if (!snapshot.hasData || snapshot.data?.size == 0) {
          return const Center(
            child: Text('No categories, yet'),
          );
        }

        return ListView.builder(
          itemBuilder: (context, index) {
            final doc = snapshot.data!.docs[index];
            final category = CategoriesRecord.getDocumentFromData(
              doc.data()! as Map<String, dynamic>,
              doc.reference,
            );
            return ListTile(
              title: Text('Category $index'),
              onTap: () => onTap(doc.reference),
            );
          },
          itemCount: snapshot.data!.size,
        );
      },
    );
  }
}
