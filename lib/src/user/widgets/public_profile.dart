import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/src/user/widgets/block.dart';
import 'package:flutter/material.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutterflow_widgets/flutterflow_widgets.dart';

/// 공개 프로필을 보여주는 위젯
///
/// [user] 또는 [userDocumentReference] 중 하나만 입력해야 한다.
/// 가능한 [user] 를 사용해서 빠르게 화면에 표시한다.
///
///
/// 예
/// ```dart
/// PublicProfile(user: user)
/// PublicProfile(userDocumentReference: user!.reference),
/// ```
class PublicProfile extends StatefulWidget {
  const PublicProfile({
    super.key,
    this.user,
    this.userDocumentReference,
    // this.onChat,
  });

  final UserModel? user;
  final DocumentReference? userDocumentReference;

  // final void Function(UserModel user)? onChat;

  @override
  State<PublicProfile> createState() => _PublicProfileState();
}

class _PublicProfileState extends State<PublicProfile> {
  UserModel? user;

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      user = widget.user;
    } else {
      UserService.instance.get(widget.userDocumentReference!.id).then((user) {
        setState(() {
          this.user = user;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) return const SizedBox.shrink();
    return Container(
      margin: const EdgeInsets.all(24),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            radius: 64,
            backgroundImage: CachedNetworkImageProvider(
              user?.photoUrl ?? 'https://via.placeholder.com/150',
            ),
          ),
          const SizedBox(height: 24),
          TextWithLabel(
            label: 'Display Name',
            text: user?.displayName ?? '',
          ),
          const SizedBox(height: 24),
          Wrap(
            children: [
              /// 채팅
              if (Config.instance.onChat != null)
                TextButton.icon(
                  onPressed: () => Config.instance.onChat!(user!),
                  icon: const Icon(Icons.chat_bubble_outline),
                  label: const Text('Chat'),
                ),

              /// 팔로우
              TextButton.icon(
                onPressed: () async {
                  final re = await UserService.instance.follow(user!.reference);

                  if (mounted) {
                    success(
                      context,
                      ln(re ? 'followed' : 'unfollowed',
                          replace: {'name': user!.displayName}),
                    );
                  }
                },
                icon: Follow(
                    userDocumentReference: user!.reference,
                    builder: (isFollowing) {
                      return Icon(
                        isFollowing ? Icons.favorite : Icons.favorite_border,
                      );
                    }),
                label: const Text('Follow'),
              ),

              /// 즐겨찾기
              TextButton.icon(
                onPressed: () async {
                  bool re = await FavoriteService.instance
                      .set(targetDocumentReference: user!.reference);

                  if (mounted) {
                    success(
                      context,
                      ln(re ? 'favorite' : 'unfavorite',
                          replace: {'name': user!.displayName}),
                    );
                  }
                },
                icon: Favorite(
                    targetDocumentReference: user!.reference,
                    builder: (isFavorite) {
                      return Icon(
                        isFavorite ? Icons.star : Icons.star_border,
                      );
                    }),
                label: const Text('Favorite'),
              ),

              /// 차단
              Block(
                userDocumentReference: user!.reference,
                builder: (isBlocked) => IconText(
                  icon: isBlocked ? Icons.block : Icons.circle_outlined,
                  text: 'Block',
                ),
                onChange: (value) => success(
                  context,
                  ln(value ? 'blocked' : 'unblocked',
                      replace: {'name': user!.displayName}),
                ),
              ),

              /// 신고
              TextButton.icon(
                onPressed: () async {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return ReportForm(
                        targetDocumentReference: user!.reference,
                        reportee: user!.reference,
                        onSuccess: () {
                          Navigator.of(context).pop();
                          success(context, ln('report_success'));
                        },
                      );
                    },
                  );
                },
                icon: const Icon(Icons.report),
                label: const Text('Report'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
