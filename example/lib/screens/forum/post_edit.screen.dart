import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Edit'),
      ),
      body: Container(
        child: Column(
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
            ElevatedButton(
              onPressed: () async {
                final data = {
                  'category': widget.category,
                  'userDocumentReference': UserService.instance.ref,
                  'title': title.text,
                  'content': content.text,
                  'createdAt': FieldValue.serverTimestamp(),
                };
                final ref = await PostService.instance.col.add(data);
                PostService.instance.afterCreate(postDocumentReference: ref);
                context.pop();
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
