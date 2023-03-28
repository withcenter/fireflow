import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:fireflow/src/user/widgets/other_doc.dart';
import 'package:flutter/material.dart';

class PostViewBody extends StatefulWidget {
  const PostViewBody({
    super.key,
    required this.post,
    required this.onEdit,
    required this.onDelete,
  });

  final PostModel post;
  final void Function(PostModel) onEdit;
  final void Function(PostModel) onDelete;

  @override
  State<PostViewBody> createState() => _PostViewBodyState();
}

class _PostViewBodyState extends State<PostViewBody> {
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.post.deleted ? Config.deletedPost : widget.post.title),
        OtherDoc(
            otherUserDocumentReference: widget.post.userDocumentReference,
            builder: (user) {
              return Text(user.displayName);
            }),
        Text(
            "post id: ${widget.post.id}, uid: ${widget.post.userDocumentReference.id}",
            style: const TextStyle(color: Colors.grey, fontSize: 10)),
        Container(
          width: double.infinity,
          color: Colors.grey.shade200,
          padding: const EdgeInsets.all(24.0),
          child: Text(widget.post.content),
        ),
        SizedBox(
          width: double.infinity,
          child: Wrap(
            runAlignment: WrapAlignment.start,
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: widget.post.files.map((url) {
              return SizedBox(
                width: 100,
                height: 100,
                child: Image.network(url),
              );
            }).toList(),
          ),
        ),
        Row(
          children: [
            TextButton(
              onPressed: () async {
                final re = await confirm(context, 'Delete', 'Are you sure?');
                if (re != true) return;
                await widget.post.delete();
                widget.onDelete(widget.post);
              },
              child: const Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                widget.onEdit(widget.post);
              },
              child: const Text('Edit'),
            ),
            TextButton(
              onPressed: () async {
                if (widget.post.likes.contains(my.reference)) {
                  widget.post.update({
                    'likes': FieldValue.arrayRemove(
                      [my.reference],
                    ),
                    'hasLike': widget.post.likes.length > 1,
                  });
                } else {
                  widget.post.update({
                    'likes': FieldValue.arrayUnion(
                      [my.reference],
                    ),
                    'hasLike': true,
                  });
                }
              },
              child: Text('Like (${widget.post.likes.length})'),
            ),
            const Spacer(),
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    value: 'profile',
                    child: Text('Profile'),
                  ),
                  const PopupMenuItem(
                    value: 'follow',
                    child: Text('Follow'),
                  ),
                  const PopupMenuItem(
                    value: 'favorite',
                    child: Text('Favorite'),
                  ),
                  const PopupMenuItem(
                    value: 'block',
                    child: Text('Block'),
                  ),
                  const PopupMenuItem(
                    value: 'report',
                    child: Text('Report'),
                  ),
                ];
              },
              onSelected: (value) {
                switch (value) {
                  case 'profile':
                    // generate code for opening bottom dialog
                    showGeneralDialog(
                        context: context,
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return Scaffold(
                            appBar: AppBar(title: const Text('Profile')),
                            body: const Center(
                              child: Text('Profile'),
                            ),
                          );
                        });
                    break;
                }
              },
            ),
          ],
        ),
        TextField(
          controller: commentController,
          decoration: const InputDecoration(
            hintText: 'Comment',
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            CommentService.instance.create(
              categoryId: widget.post.categoryId,
              postDocumentReference: widget.post.reference,
              userDocumentReference: UserService.instance.ref,
              content: commentController.text,
            );
          },
          child: const Text('Reply'),
        ),
      ],
    );
  }
}
