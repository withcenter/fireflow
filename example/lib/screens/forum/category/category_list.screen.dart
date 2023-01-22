import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CategoryListScreen extends StatelessWidget {
  const CategoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              context.pushNamed('CategoryEdit');
            },
          ),
        ],
      ),
      body: StreamBuilder(
          stream: CategoryService.instance.col.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData == false)
              return const Text('No categories found');
            if (snapshot.data!.size == 0)
              return const Text('No categories found');

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final category =
                    CategoryModel.fromSnapshot(snapshot.data!.docs[index]);
                return ListTile(
                  title: Text(category.title),
                  onTap: () {
                    context.pushNamed('CategoryEdit',
                        queryParams: {'category': category.category});
                  },
                );
              },
            );
          }),
    );
  }
}
