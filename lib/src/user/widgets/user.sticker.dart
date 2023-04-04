import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

/// 다목적 사용자 정보 표시 스티커
///
/// 왼쪽에 사용자 프로필 사진, 오른쪽에 사용자 이름, 가입 날짜, 성별, 나일 등을 옵션으로 표시한다.
/// 사용자 목록/검색, 채팅 목록에 1:1 친구 목록 등에서 사용 될 수 있다.
///
/// 주의, Stream 으로 업데이트하지 않는다. 실시간 업데이트를 원하면, UserStickerStream 을 사용한다.
///
class UserSticker extends StatelessWidget {
  const UserSticker({
    super.key,
    this.user,
    this.reference,
    this.userPhotoRadius = 24,
    required this.onTap,
    this.title,
    this.displayName = true,
    this.uid = false,
    this.trailing,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(16),
    this.decoration,
  })  : assert(user != null || reference != null),
        assert(user == null || reference == null);

  /// 사용자의 DocumentReference
  /// [user] 와 [reference] 둘 중 하나만 입력해야 한다.
  final DocumentReference? reference;
  final UserModel? user;
  final double userPhotoRadius;

  final void Function(UserModel doc) onTap;

  final Widget? title;

  final bool displayName;
  final bool uid;

  final Widget? trailing;

  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      return _sticker(user!);
    } else {
      return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _sticker(snapshot.data as UserModel);
          } else {
            return const SizedBox.shrink();
          }
        },
        future: UserService.instance.get(reference!.id),
      );
    }
  }

  Widget _sticker(UserModel user) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap(user),
      child: Container(
        margin: margin,
        padding: padding,
        decoration: decoration,
        child: Row(
          children: [
            UserAvatar(
              user: user,
              padding: const EdgeInsets.only(right: 16),
              radius: userPhotoRadius,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null) title!,
                  if (displayName)
                    Text(user.displayName == ''
                        ? 'No display name'
                        : user.displayName),
                  if (uid)
                    Text(
                      'UID: ${user.uid}',
                      style: const TextStyle(fontSize: 10),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                ],
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
