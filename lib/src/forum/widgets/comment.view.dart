
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

class CommentView extends StatelessWidget {
  const CommentView({
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
                      return Column(
                        children: [
                          TextField(
                            controller: replyComment,
                            decoration: const InputDecoration(
                              hintText: 'Comment',
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              final nav = Navigator.of(context);
                              // final data = {
                              //   'postDocumentReference':
                              //       comment.postDocumentReference,
                              //   'parentCommentDocumentReference':
                              //       CommentService.instance.doc(comment.id),
                              //   'userDocumentReference':
                              //       UserService.instance.ref,
                              //   'content': replyComment.text,
                              //   'createdAt': FieldValue.serverTimestamp(),
                              //   'order': commentOrder(comment.order,
                              //       comment.depth, post.noOfComments),
                              //   'depth': comment.depth + 1,
                              // };

                              CommentService.instance.create(
                                categoryId: post.categoryId,
                                postDocumentReference:
                                    comment.postDocumentReference,
                                userDocumentReference: UserService.instance.ref,
                                content: replyComment.text,
                                parentOrder: comment.order,
                                parentDepth: comment.depth,
                                postNoOfComment: post.noOfComments,
                              );
                              // Navigator.pop(context);
                              nav.pop();
                            },
                            child: const Text('Reply'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Reply'),
              ),
              TextButton(
                onPressed: () {
                  final editComment =
                      TextEditingController(text: comment.content);
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Column(
                        children: [
                          TextField(
                            controller: editComment,
                            decoration: const InputDecoration(
                              hintText: 'Comment',
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              final nav = Navigator.of(context);
                              // await comment.ref.update({
                              //   'content': editComment.text,
                              // });
                              CommentService.instance.update(
                                commentDocumentReference: comment.reference,
                                content: editComment.text,
                              );
                              // Navigator.pop(context);
                              nav.pop();
                            },
                            child: const Text('Edit'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Edit'),
              ),
              TextButton(
                onPressed: () async {
                  CommentService.instance
                      .delete(commentDocumentReference: comment.reference);
                },
                child: const Text('Delete'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
