import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

/// 글 보기 위젯
///
/// 참고, 입력 값을 Map 으로 받는데, FF 에서는 BuiltValue 를 통한 Schema 를 쓰는데,
///
class PostView extends StatefulWidget {
  const PostView({super.key, this.post, this.json});

  final PostModel? post;
  final Map<String, dynamic>? json;

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  late PostModel post;

  final TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.post != null) {
      post = widget.post!;
    } else {
      post = PostModel.fromJson(widget.json!,
          reference: PostService.instance.doc(widget.json!['postId']));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.deleted ? '---deleted---' : post.title),
            Text("post id: ${post.id}, uid: ${post.userDocumentReference.id}",
                style: const TextStyle(color: Colors.grey, fontSize: 10)),
            Container(
              width: double.infinity,
              color: Colors.grey.shade200,
              padding: const EdgeInsets.all(24.0),
              child: Text(post.content),
            ),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                runAlignment: WrapAlignment.start,
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: post.files.map((url) {
                  return SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.network(url),
                  );
                }).toList(),
              ),
            ),
            TextField(
              controller: commentController,
              decoration: const InputDecoration(
                hintText: 'Comment',
              ),
            ),
            Wrap(
              children: [
                TextButton(
                  onPressed: () async {
                    final navigator = Navigator.of(context);
                    await post.reference.update({'deleted': true});
                    PostService.instance
                        .afterDelete(postDocumentReference: post.reference);

                    navigator.pop();
                  },
                  child: const Text('Delete'),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                CommentService.instance.create(
                  categoryId: post.categoryId,
                  postDocumentReference: post.reference,
                  userDocumentReference: UserService.instance.ref,
                  content: commentController.text,
                );
              },
              child: const Text('Submit'),
            ),
            StreamBuilder(
              stream: CommentService.instance.children(post.id),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  dog('Error, ${snapshot.error}}');
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
                    final comment = CommentModel.fromSnapshot(docs[index]);
                    return CommentView(post: post, comment: comment);
                  },
                  itemCount: snapshot.data?.docs.length,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
