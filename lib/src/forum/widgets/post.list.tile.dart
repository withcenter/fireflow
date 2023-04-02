import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

/// 글 목록 위젯
///
/// 글 목록 페이지에서 각 글(제목) 하나를 표시 할 때 사용하는 위젯. 또는 각종 경우에서 글 제목(시간, 사용자 정보 등 메타 포함)
/// 하나를 표시 할 때 사용하면 된다.
///
/// 글이 탭 되면, [onTap] 콜백이 지정되었으면 [onTap] 이 호출한다.
class PostListTile extends StatelessWidget {
  const PostListTile({
    super.key,
    required this.post,
    required this.onTap,
  });

  final PostModel post;
  final void Function(PostModel) onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(post.deleted ? Config.deletedPost : post.title),
      subtitle: Wrap(
        children: [
          Text(post.id),
          const SizedBox(width: 8),
          Text(post.deleted
              ? Config.deletedPost
              : post.createdAt.toDate().toString()),
          const SizedBox(width: 8),
          UserDoc(
            reference: post.userDocumentReference,
            builder: (user) {
              return Text(user.displayName);
            },
          ),
        ],
      ),
      onTap: () => onTap(post),
    );
  }
}
