import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

/// 글 보기 위젯
///
///
///
class PostView extends StatefulWidget {
  const PostView({
    super.key,
    required this.post,
    required this.onEdit,
    required this.onDelete,
  });

  final PostModel post;
  final void Function(PostModel) onEdit;
  final void Function(PostModel) onDelete;

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  late PostModel post;

  @override
  void initState() {
    super.initState();

    post = widget.post;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// TODO: (처리) 갑자기 글이 삭제되는 경우, 여기서 에러가 난다.
        StreamBuilder(
          stream: post.reference.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.hasError ||
                snapshot.hasData == false) {
              return PostViewBody(
                post: post,
                onEdit: widget.onEdit,
                onDelete: widget.onDelete,
              );
            }
            if (snapshot.data == null || snapshot.data!.exists == false) {
              dog('글이 없거나, 글이 갑자기 삭제되면 이곳으로 온다.');
              return const Center(
                child: Text(
                    'snapshot.data is not exist. Or the post has just deleted.'),
              );
            }
            post = PostModel.fromSnapshot(snapshot.data!);
            return PostViewBody(
              post: post,
              onEdit: widget.onEdit,
              onDelete: widget.onDelete,
            );
          },
        ),

        /// 코멘트 목록
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
    );
  }
}
