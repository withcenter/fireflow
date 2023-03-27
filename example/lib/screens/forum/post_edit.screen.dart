import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

class PostEditScreen extends StatefulWidget {
  const PostEditScreen({super.key, this.category, this.postId});

  final String? category;
  final String? postId;
  @override
  State<PostEditScreen> createState() => _PostEditScreenState();
}

class _PostEditScreenState extends State<PostEditScreen> {
  final title = TextEditingController();
  final content = TextEditingController();
  final List<String> files = [];

  late final PostModel post;

  bool get isCreate => widget.postId == null;

  @override
  void initState() {
    super.initState();

    if (widget.postId != null) {
      PostService.instance.col.doc(widget.postId).get().then((value) {
        post = PostModel.fromSnapshot(value);
        title.text = post.title;
        content.text = post.content;
        files.addAll(post.files);
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Edit'),
      ),
      body: Column(
        children: [
          TextField(
            controller: title,
            decoration: const InputDecoration(
              hintText: 'Title',
            ),
          ),
          TextField(
            controller: content,
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
                    setState(() {
                      files.addAll(uploadedUrls);
                    });
                  },
                  icon: const Icon(Icons.camera_alt)),
              const Spacer(),
              ElevatedButton(
                onPressed: () async {
                  if (isCreate) {
                    create();
                  } else {
                    update();
                  }

                  context.pop();
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
              children: files.map((url) {
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
                        files.remove(url);
                        if (isCreate == false) {
                          await PostService.instance
                              .doc(widget.postId!)
                              .update({
                            'files': FieldValue.arrayRemove([url]),
                          });
                        }
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
      ),
    );
  }

  create() async {
    final data = {
      'category': widget.category,
      'userDocumentReference': UserService.instance.ref,
      'title': title.text,
      'content': content.text,
      'createdAt': FieldValue.serverTimestamp(),
      'files': files,
    };
    // final ref =
    await PostService.instance.col.add(data);
    // PostService.instance.afterCreate(postDocumentReference: ref);
  }

  update() async {
    final data = {
      'title': title.text,
      'content': content.text,
      'files': files,
    };
    await PostService.instance.doc(widget.postId!).update(data);
    PostService.instance.afterUpdate(
      postDocumentReference: PostService.instance.doc(widget.postId!),
    );
  }
}
