import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:fireflow/src/user/widgets/other_doc.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_widgets/flutterflow_widgets.dart';

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
  PostModel get post => widget.post;
  UserModel? user;
  final TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 주의, 화면 깜박임을 위해서, setState 를 사용하지 않는다.
    UserService.instance
        .get(post.userDocumentReference.id)
        .then((value) => user = value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(post.deleted ? Config.deletedPost : post.title),
        OtherDoc(
            otherUserDocumentReference: post.userDocumentReference,
            builder: (user) {
              return Text(user.displayName);
            }),
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
        Row(
          children: [
            TextButton(
              onPressed: () async {
                final re = await confirm(context, 'Delete', 'Are you sure?');
                if (re != true) return;
                await post.delete();
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
                if (post.likes.contains(my.reference)) {
                  post.update({
                    'likes': FieldValue.arrayRemove(
                      [my.reference],
                    ),
                    'hasLike': post.likes.length > 1,
                  });
                } else {
                  post.update({
                    'likes': FieldValue.arrayUnion(
                      [my.reference],
                    ),
                    'hasLike': true,
                  });
                }
              },
              child: Text('Like (${post.likes.length})'),
            ),
            const Spacer(),

            /// 게시 글 메뉴: 더보기
            CustomIconPopup(
              icon: Container(
                padding: const EdgeInsets.all(12),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(64)),
                child: const Icon(Icons.more_vert),
              ),
              popup: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // 사용자 프로필
                    if (user != null)
                      UserSticker(
                          user: user!,
                          onTap: (user) {
                            Navigator.of(context).pop();
                            showUserProfile();
                          }),
                    // 프로필 보기
                    ListTile(
                      leading: const Icon(Icons.person_outline),
                      title: const Text('Profile'),
                      onTap: () {
                        Navigator.of(context).pop();
                        showUserProfile();
                      },
                    ),
                    // 팔로우
                    if (my.reference != user?.reference)
                      MyDoc(
                        builder: (my) => ListTile(
                          leading: Icon(my.followings.contains(user!.reference)
                              ? Icons.favorite
                              : Icons.favorite_border),
                          title: const Text('Follow'),
                          onTap: () {
                            final contains =
                                my.followings.contains(user!.reference);
                            Navigator.of(context).pop();
                            UserService.instance.update(
                              followings: contains
                                  ? FieldValue.arrayRemove([user!.reference])
                                  : FieldValue.arrayUnion([user!.reference]),
                            );
                            success(context,
                                'You have ${contains ? 'un-followed' : 'followed'} ${user!.displayName}');
                          },
                        ),
                      ),

                    // ListTile(
                    //   leading: const Icon(Icons.star_border),
                    //   title: const Text('Favorite'),
                    //   onTap: () {
                    //     print('favorite');
                    //     Navigator.of(context).pop();
                    //   },
                    // ),
                    if (my.reference != user?.reference)
                      MyDoc(builder: (my) {
                        final contains =
                            my.blockedUsers.contains(user!.reference);
                        return ListTile(
                          leading: Icon(
                              contains ? Icons.block : Icons.circle_outlined),
                          title: const Text('Block'),
                          onTap: () {
                            Navigator.of(context).pop();
                            UserService.instance.update(
                              blockedUsers: contains
                                  ? FieldValue.arrayRemove([user!.reference])
                                  : FieldValue.arrayUnion([user!.reference]),
                            );
                            success(context,
                                'You have ${contains ? 'un-blocked' : 'blocked'} ${user!.displayName}');
                          },
                        );
                      }),
                    ListTile(
                      leading: const Icon(Icons.report_outlined),
                      title: const Text('Report'),
                      onTap: () {
                        Navigator.of(context).pop();
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return ReportForm(
                              target: post.reference,
                              reportee: post.userDocumentReference,
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
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
              categoryId: post.categoryId,
              postDocumentReference: post.reference,
              userDocumentReference: UserService.instance.ref,
              content: commentController.text,
            );
          },
          child: const Text('Reply'),
        ),
      ],
    );
  }

  showUserProfile() {
    // 로직을 간단히 하기 위해서, 새로운 화면으로 이동하지 않고, 현재 화면에서 사용자 프로필을 보여준다.
    showGeneralDialog(
        context: context,
        pageBuilder: (context, animation, secondaryAnimation) {
          return Scaffold(
            appBar: AppBar(title: const Text('Profile')),
            body: PublicProfile(user: user!),
          );
        });
  }
}
