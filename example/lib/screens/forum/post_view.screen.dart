import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PostViewScreen extends StatefulWidget {
  const PostViewScreen({super.key, required this.postDocumentReference});

  final DocumentReference postDocumentReference;

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
              'postId': widget.postDocumentReference.id,
            }),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: widget.postDocumentReference.snapshots(),
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
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post.deleted ? '---deleted---' : post.title),
                  Text(
                      "post id: ${post.id}, uid: ${post.userDocumentReference.id}",
                      style: const TextStyle(color: Colors.grey, fontSize: 10)),
                  Container(
                    width: double.infinity,
                    color: Colors.grey.shade200,
                    padding: const EdgeInsets.all(24.0),
                    child: Text(post.content),
                  ),
                  Container(
                    width: double.infinity,
                    child: Wrap(
                      runAlignment: WrapAlignment.start,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: post.files.map((url) {
                        return Container(
                          width: 100,
                          height: 100,
                          child: Image.network(url),
                        );
                      }).toList(),
                    ),
                  ),
                  TextField(
                    controller: comment,
                    decoration: const InputDecoration(
                      hintText: 'Comment',
                    ),
                  ),
                  Wrap(
                    children: [
                      TextButton(
                        onPressed: () async {
                          await post.ref.update({'deleted': true});
                          PostService.instance
                              .afterDelete(postDocumentReference: post.ref);
                          context.pop();
                        },
                        child: Text('Delete'),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final data = {
                        'postDocumentReference': widget.postDocumentReference,
                        'userDocumentReference': UserService.instance.ref,
                        'content': comment.text,
                        'createdAt': FieldValue.serverTimestamp(),
                        'order': commentOrder(null, null, post.noOfComments),
                        'depth': 1,
                      };

                      final ref = await CommentService.instance.col.add(data);
                      CommentService.instance
                          .afterCreate(commentDocumentReference: ref);
                    },
                    child: const Text('Submit'),
                  ),
                  StreamBuilder(
                    stream: CommentService.instance.children(post.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                        return Center(
                          child: Text('Error, ${snapshot.error}}'),
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
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final comment =
                              CommentModel.fromSnapshot(docs[index]);
                          return CommentWidget(post: post, comment: comment);
                        },
                        itemCount: snapshot.data?.docs.length,
                      );
                    },
                  ),
                ],
              ),
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
    required this.post,
    required this.comment,
  }) : super(key: key);

  final PostModel post;
  final CommentModel comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16 * (comment.depth - 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(comment.deleted ? '---deleted---' : comment.content),
          Text('id: ${comment.id}, uid: ${comment.userDocumentReference.id}',
              style: const TextStyle(color: Colors.grey, fontSize: 10)),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  final replyComment = TextEditingController();
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        child: Column(
                          children: [
                            TextField(
                              controller: replyComment,
                              decoration: const InputDecoration(
                                hintText: 'Comment',
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                final data = {
                                  'postDocumentReference':
                                      comment.postDocumentReference,
                                  'parentCommentDocumentReference':
                                      CommentService.instance.doc(comment.id),
                                  'userDocumentReference':
                                      UserService.instance.ref,
                                  'content': replyComment.text,
                                  'createdAt': FieldValue.serverTimestamp(),
                                  'order': commentOrder(comment.order,
                                      comment.depth, post.noOfComments),
                                  'depth': comment.depth + 1,
                                };
                                final ref =
                                    await CommentService.instance.col.add(data);

                                CommentService.instance
                                    .afterCreate(commentDocumentReference: ref);
                                Navigator.pop(context);
                              },
                              child: const Text('Reply'),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Text('Reply'),
              ),
              TextButton(
                onPressed: () {
                  final editComment =
                      TextEditingController(text: comment.content);
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
                                await comment.ref.update({
                                  'content': editComment.text,
                                });
                                CommentService.instance.afterUpdate(
                                    commentDocumentReference: comment.ref);
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
                onPressed: () async {
                  await comment.ref.update({'deleted': true});
                  CommentService.instance
                      .afterDelete(commentDocumentReference: comment.ref);
                },
                child: Text('Delete'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
