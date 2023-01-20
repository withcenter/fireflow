import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PostViewScreen extends StatefulWidget {
  const PostViewScreen({super.key, required this.postId});

  final String postId;

  @override
  State<PostViewScreen> createState() => _PostViewScreenState();
}

class _PostViewScreenState extends State<PostViewScreen> {
  final comment = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PostView'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.pushNamed('PostEdit', queryParams: {
              'postId': widget.postId,
            }),
          ),
        ],
      ),
      body: FutureBuilder(
        future: PostService.instance.doc(widget.postId).get(),
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
          final post = PostModel.fromSnapshot(snapshot.data!);
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(post.title),
                Container(width: double.infinity, color: Colors.grey.shade200, padding: const EdgeInsets.all(24.0), child: Text(post.content)),
                TextField(
                  controller: comment,
                  decoration: const InputDecoration(
                    hintText: 'Comment',
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final ref = await CommentService.instance.col.add({
                      'postDocumentReference': PostService.instance.doc(widget.postId),
                      'userDocumentReference': UserService.instance.ref,
                      'content': comment.text,
                      'createdAt': FieldValue.serverTimestamp(),
                    });

                    await CommentService.instance.afterCreate(commentDocumentReference: ref);
                  },
                  child: const Text('Submit'),
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: CommentService.instance.children(post.id),
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
                      if ((snapshot.data?.size ?? 0) == 0) {
                        return const Center(
                          child: Text('No comments'),
                        );
                      }
                      final docs = snapshot.data!.docs;

                      return ListView.builder(
                        itemBuilder: (context, index) {
                          final comment = CommentModel.fromSnapshot(docs[index]);
                          return CommentWidget(comment: comment);
                        },
                        itemCount: snapshot.data?.docs.length,
                      );
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    Key? key,
    required this.comment,
  }) : super(key: key);

  final CommentModel comment;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(comment.content),
      subtitle: Row(
        children: [
          TextButton(
            onPressed: () {
              final editComment = TextEditingController(text: comment.content);
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    child: Column(
                      children: [
                        TextField(
                          controller: editComment,
                          decoration: const InputDecoration(
                            hintText: 'Comment',
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            await snapshot.data!.docs[index].reference.update({
                              'content': editComment.text,
                            });
                            CommentService.instance.afterUpdate(commentDocumentReference: snapshot.data!.docs[index].reference);
                            Navigator.pop(context);
                          },
                          child: const Text('Edit'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Text('Edit'),
          ),
          TextButton(
            onPressed: () {},
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}
