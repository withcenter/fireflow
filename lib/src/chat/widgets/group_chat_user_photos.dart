import 'package:flutter/material.dart';

import 'package:fireflow/fireflow.dart';

/// 그룹 채팅방의 사용자들의 사진을 보여준다.
///
/// 첫번째 사진은 마지막 메시지를 보낸 사람의 사진이고,
/// 두번째 사진은 마지막 입장한 사람이다.
///
/// TODO: 버그 - 마지막 입장한 사람과 마지막 채팅한 사람이 실시간으로 프로필 사진이 잘 안바뀐다. 동작하는데 큰 문제는 없어 보이는데, 뭔가 조금 이상하다. 나중에 살펴봐야 한다.
class GroupChatUserPhotos extends StatelessWidget {
  const GroupChatUserPhotos({
    super.key,
    required this.room,
    this.border = 1,
    this.borderColor = Colors.white,
    this.radius = 14,
    this.size = 38,
  });

  final ChatRoomModel room;

  final double size;

  final double border;
  final Color borderColor;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: room.lastMessageSentBy == null ? size : size * 1.74,
      child: Stack(
        children: [
          /// 마지막 채팅한 사용자. 방이 막 만들어 진 경우, 마지막 채팅 사용자가 없을 수 있다.
          if (room.lastMessageSentBy != null)
            Align(
              alignment: Alignment.centerLeft,
              child: UserDoc(
                key: ValueKey(room.lastMessageSentBy),
                reference: room.lastMessagedUser,
                builder: (user) => UserAvatar(
                  user: user,
                  size: size,
                  border: border,
                  borderColor: borderColor,
                  radius: radius,
                ),
              ),
            ),

          /// 마지막 입장한 사용자. 마지막 입장한 사용자는 늘 존재.
          Align(
            alignment: Alignment.centerRight,
            child: UserDoc(
              key: ValueKey(room.lastEnteredUser),
              reference: room.lastEnteredUser,
              builder: (user) => UserAvatar(
                user: user,
                size: size,
                border: border,
                borderColor: borderColor,
                radius: radius,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
