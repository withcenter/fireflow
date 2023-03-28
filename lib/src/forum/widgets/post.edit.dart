import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

class PostEdit extends StatefulWidget {
  const PostEdit({
    super.key,
    required this.postDocumentReference,
    required this.onEdit,
    required this.onFileUpload,
  });

  final DocumentReference postDocumentReference;
  final void Function(PostModel) onEdit;
  final void Function(PostModel) onFileUpload;

  @override
  State<PostEdit> createState() => _PostEditState();
}

class _PostEditState extends State<PostEdit> {
  PostModel? _post;
  PostModel get post => _post!;

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    PostService.instance
        .get(widget.postDocumentReference.id)
        .then((post) => setState(() {
              _post = post;
              titleController.text = post.title;
              contentController.text = post.content;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return _post == null
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Title',
                ),
              ),
              TextField(
                controller: contentController,
                decoration: const InputDecoration(
                  hintText: 'Content',
                ),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () async {
                        final uploadedUrls =
                            await StorageService.instance.uploadMedia(
                          context: context,
                          allowPhoto: true,
                          allowAnyfile: true,
                          allowVideo: true,
                          multiImage: false,
                          maxHeight: 1024,
                          maxWidth: 1024,
                          imageQuality: 80,
                        );
                        post.files.addAll(uploadedUrls);
                        await post
                            .update(PostModel.toUpdate(files: post.files));
                        setState(() {});
                        widget.onFileUpload(post);
                      },
                      icon: const Icon(Icons.camera_alt)),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      await post.update(
                        PostModel.toUpdate(
                            title: titleController.text,
                            content: contentController.text,
                            files: post.files),
                      );

                      widget.onEdit(post);
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: Wrap(
                  runAlignment: WrapAlignment.start,
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: post.files.map((url) {
                    return Stack(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.network(url),
                        ),
                        IconButton(
                          onPressed: () async {
                            await StorageService.instance.delete(url);

                            post.files.remove(url);

                            await post.update({
                              'files': FieldValue.arrayRemove([url]),
                            });

                            setState(() {});
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red.shade700,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          );
  }
}
