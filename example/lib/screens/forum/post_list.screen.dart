import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';

class PostListScreen extends StatelessWidget {
  const PostListScreen({super.key, required this.category});

  final String category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$category'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.pushNamed('PostEdit', queryParams: {
              'category': category,
            }),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: PostService.instance.col
            .where('category', isEqualTo: category)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data?.docs.length == 0) {
            return const Center(
              child: Text('No data'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              final post = PostModel.fromSnapshot(snapshot.data!.docs[index]);
              return ListTile(
                title: Text(post.title),
                subtitle: Text(post.content),
                onTap: () => context.pushNamed('PostEdit', queryParams: {
                  'postId': post.id,
                }),
              );
            },
          );
        },
      ),
    );
  }
}
