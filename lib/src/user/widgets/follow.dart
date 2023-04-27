import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

/// 팔로잉 위젯
///
/// 팔로잉 했는지 하지 않았는지를 바탕으로 자식 위젯을 빌드 할 수 있도록 해 준다.
/// 팔로잉 한 상탱이면, true. 아니면 false 를 [builder] 로 전달.
///
///
///
class Follow extends StatelessWidget {
  const Follow({
    Key? key,
    required this.userDocumentReference,
    required this.builder,
  }) : super(key: key);
  final DocumentReference userDocumentReference;
  final Widget Function(bool isFollowing) builder;

  @override
  Widget build(BuildContext context) {
    if (userDocumentReference == my.reference) {
      return const SizedBox.shrink();
    }

    return AuthStream(
      login: (_) {
        return builder(my.followings.contains(userDocumentReference));
      },
      logout: () => const SizedBox.shrink(),
    );
  }
}
