import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

class FavoritePostTile extends StatelessWidget {
  const FavoritePostTile({
    super.key,
    required this.postDocumentReference,
  });
  final DocumentReference postDocumentReference;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox.shrink();
        }
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return const SizedBox.shrink();
        } else {
          final PostModel post = snapshot.data as PostModel;

          return UserDoc(
              reference: post.userDocumentReference,
              builder: (user) {
                return UserSticker(
                    user: user,
                    title: Text(post.title),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: (user) {
                      showPostViewDialog(context: context, post: post);
                    });
              });
        }
      },
      future: PostService.instance.get(postDocumentReference.id),
    );
  }
}
