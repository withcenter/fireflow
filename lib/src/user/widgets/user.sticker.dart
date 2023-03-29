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
    required this.user,
    required this.onTap,
  });

  /// 사용자의 DocumentReference
  final UserModel user;

  final void Function(UserModel doc) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(user),
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            UserAvatar(user: user, padding: const EdgeInsets.only(right: 16)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.displayName == ''
                    ? 'No display name'
                    : user.displayName),
                Text('UID: ${user.uid}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
