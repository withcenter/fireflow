import 'package:cloud_firestore/cloud_firestore.dart';
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
          StreamBuilder(
            stream: UserSettingService.instance.ref.snapshots(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
                return Icon(Icons.error_outline);
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final setting = UserSettingModel.fromSnapshot(snapshot.data!);
              final categoryDocumentReference = CategoryService.instance.doc(category);

              return IconButton(
                  onPressed: () {
                    UserSettingService.instance.ref.update({
                      'postSubscriptions': setting.postSubscriptions.contains(categoryDocumentReference)
                          ? FieldValue.arrayRemove([categoryDocumentReference])
                          : FieldValue.arrayUnion([categoryDocumentReference])
                    });
                  },
                  icon: setting.postSubscriptions.contains(categoryDocumentReference)
                      ? Icon(Icons.notifications_active_outlined)
                      : Icon(Icons.notifications_off_outlined));
            },
          ),
          StreamBuilder(
            stream: UserSettingService.instance.ref.snapshots(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
                return Icon(Icons.error_outline);
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final setting = UserSettingModel.fromSnapshot(snapshot.data!);
              final categoryDocumentReference = CategoryService.instance.doc(category);

              return IconButton(
                  onPressed: () {
                    UserSettingService.instance.ref.update({
                      'commentSubscriptions': setting.commentSubscriptions.contains(categoryDocumentReference)
                          ? FieldValue.arrayRemove([categoryDocumentReference])
                          : FieldValue.arrayUnion([categoryDocumentReference])
                    });
                  },
                  icon: setting.commentSubscriptions.contains(categoryDocumentReference) ? Icon(Icons.comment) : Icon(Icons.comments_disabled_outlined));
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.pushNamed('PostEdit', queryParams: {
              'category': category,
            }),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: PostService.instance.col.where('category', isEqualTo: category).orderBy('createdAt', descending: true).snapshots(),
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
                title: Text(post.deleted ? '---deleted---' : post.title),
                subtitle: Text(post.content),
                onTap: () => context.pushNamed(
                  'postView',
                  queryParams: {
                    'postDocumentReference': post.ref.path,
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
