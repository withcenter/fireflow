import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_widgets/flutterflow_widgets.dart';

/// 글 보기 위젯
///
/// 글 제목, 작성자, 날짜, 내용, 사진, 좋아요, 댓글 및 기타 버튼 표시.
class PostViewBody extends StatefulWidget {
  const PostViewBody({
    super.key,
    required this.post,
    required this.onEdit,
    required this.onDelete,
    // this.onChat,
  });

  final PostModel post;
  final void Function(PostModel) onEdit;
  final void Function(PostModel) onDelete;
  // final void Function(UserModel)? onChat;

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
        UserDoc(
            reference: post.userDocumentReference,
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

            /// 게시 글 메뉴: 더보기 버튼
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
                    /// 사용자 프로필
                    if (user != null)
                      UserSticker(
                          user: user!,
                          onTap: (user) {
                            Navigator.of(context).pop();
                            showUserProfile();
                          }),

                    /// 프로필 보기
                    ListTile(
                      leading: const Icon(Icons.person_outline),
                      title: const Text('Profile'),
                      onTap: () {
                        Navigator.of(context).pop();
                        showUserProfile();
                      },
                    ),

                    /// 채팅
                    if (post.isNotMine && Config.instance.onChat != null)
                      ListTile(
                        leading: const Icon(Icons.chat_bubble_outline),
                        title: const Text('Chat'),
                        onTap: () {
                          Navigator.of(context).pop();
                          Config.instance.onChat!(user!);

                          // if (widget.onChat != null) widget.onChat!(user!);
                        },
                      ),

                    /// 팔로우
                    Follow(
                      userDocumentReference: post.userDocumentReference,
                      builder: (isFollowing) {
                        return ListTile(
                          leading: Icon(isFollowing
                              ? Icons.favorite
                              : Icons.favorite_border),
                          title: const Text('Follow'),
                          onTap: () {
                            Navigator.of(context).pop();
                            UserService.instance.update(
                              followings: isFollowing
                                  ? FieldValue.arrayRemove(
                                      [post.userDocumentReference])
                                  : FieldValue.arrayUnion(
                                      [post.userDocumentReference]),
                            );
                            success(
                              context,
                              ln(
                                isFollowing ? 'unfollowed' : 'followed',
                                replace: {
                                  'name': user!.displayName,
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),

                    // if (post.isNotMine)
                    //   MyDoc(
                    //     builder: (my) => ListTile(
                    //       leading: Icon(my.followings.contains(user!.reference)
                    //           ? Icons.favorite
                    //           : Icons.favorite_border),
                    //       title: const Text('Follow'),
                    //       onTap: () {
                    //         final contains =
                    //             my.followings.contains(user!.reference);
                    //         Navigator.of(context).pop();
                    //         UserService.instance.update(
                    //           followings: contains
                    //               ? FieldValue.arrayRemove([user!.reference])
                    //               : FieldValue.arrayUnion([user!.reference]),
                    //         );
                    //         success(
                    //           context,
                    //           ln(
                    //             contains ? 'unfollowed' : 'followed',
                    //             replace: {
                    //               'name': user!.displayName,
                    //             },
                    //           ),
                    //         );
                    //       },
                    //     ),
                    //   ),

                    /// 즐겨찾기
                    Favorite(
                      targetDocumentReference: post.reference,
                      builder: (isFavorite) => ListTile(
                        leading: Icon(
                          isFavorite ? Icons.star : Icons.star_border,
                        ),
                        title: const Text('Favorite'),
                      ),
                      onChange: (isFavorite) {
                        Navigator.of(context).pop();
                        success(
                          context,
                          ln(isFavorite ? 'favorite' : 'unfavorite',
                              replace: {'name': user!.displayName}),
                        );
                      },
                    ),
                    // Favorite(
                    //     targetDocumentReference: post.reference,
                    //     builder: (isFavorite) {
                    //       return ListTile(
                    //         leading: Icon(
                    //           isFavorite ? Icons.star : Icons.star_border,
                    //         ),
                    //         title: const Text('Favorite'),
                    //         onTap: () {
                    //           Navigator.of(context).pop();
                    //           FavoriteService.instance.set(
                    //             targetDocumentReference: post.reference,
                    //           );

                    //           success(
                    //             context,
                    //             ln(isFavorite ? 'unfavorite' : 'favorite',
                    //                 replace: {'name': user!.displayName}),
                    //           );
                    //         },
                    //       );
                    //     }),

                    /// 차단
                    if (post.isNotMine)
                      MyDoc(builder: (my) {
                        final contains =
                            my.blockedUsers.contains(user!.reference);
                        return ListTile(
                          leading: Icon(
                              contains ? Icons.block : Icons.circle_outlined),
                          title: const Text('Block'),
                          onTap: () async {
                            Navigator.of(context).pop();
                            final re = await UserService.instance
                                .block(user!.reference);
                            if (mounted) {
                              success(
                                context,
                                ln(re ? 'blocked' : 'unblocked',
                                    replace: {'name': user!.displayName}),
                              );
                              // 'You have ${contains ? 'un-blocked' : 'blocked'} ${user!.displayName}');
                            }
                          },
                        );
                      }),

                    /// 신고
                    if (post.isNotMine)
                      ListTile(
                        leading: const Icon(Icons.report_outlined),
                        title: const Text('Report'),
                        onTap: () {
                          Navigator.of(context).pop();
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return ReportForm(
                                targetDocumentReference: post.reference,
                                reportee: post.userDocumentReference,
                                onSuccess: () {
                                  Navigator.of(context).pop();
                                  success(context, ln('report_success'));
                                },
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
