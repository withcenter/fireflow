import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

/// 차단 위젯
///
/// 차단했는지 하지 않았는지를 바탕으로 자식 위젯을 빌드 할 수 있도록 해 준다.
/// 차단 한 상태이면, true. 아니면 false 를 [builder] 로 전달.
///
/// 로그인을 안했거나, 나의 프로필인 경우, 아무것도 보여주지 않는다.
class Block extends StatelessWidget {
  const Block({
    Key? key,
    required this.userDocumentReference,
    required this.builder,
    required this.onChange,
  }) : super(key: key);
  final DocumentReference userDocumentReference;
  final Widget Function(bool isBlocked) builder;
  final void Function(bool isBlocked) onChange;

  @override
  Widget build(BuildContext context) {
    if (userDocumentReference == my.reference) {
      return const SizedBox.shrink();
    }

    return AuthStream(
      login: (_) {
        return GestureDetector(
          key: ValueKey(
              'Block-${userDocumentReference.id}-${my.blockedUsers.contains(userDocumentReference)}'),
          onTap: () async {
            bool re = await UserService.instance.block(userDocumentReference);
            onChange(re);
          },
          behavior: HitTestBehavior.opaque,
          child: builder(my.blockedUsers.contains(userDocumentReference)),
        );
      },
      logout: () => const SizedBox.shrink(),
    );
  }
}
