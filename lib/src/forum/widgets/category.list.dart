import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
  });

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
              onTap: () {
                // generate a dialog with showGeneralDialog displaying category edit form using CategoryEdit widget
                showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: MaterialLocalizations.of(context)
                      .modalBarrierDismissLabel,
                  barrierColor: Colors.black45,
                  transitionDuration: const Duration(milliseconds: 200),
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return Scaffold(
                      appBar: AppBar(
                        title: const Text('Edit Category'),
                      ),
                      body: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: CategoryEdit(
                            categoryDocumentReference: category.reference,
                            onCancel: (ref) {
                              Navigator.of(context).pop();
                            },
                            onDelete: (ref) {
                              Navigator.of(context).pop();
                              success(context, 'Category deleted.');
                            },
                            onEdit: (ref) {
                              success(context, 'Category edited.');
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
          itemCount: snapshot.data!.size,
        );
      },
    );
  }
}
