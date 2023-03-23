import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'package:fireflow/fireflow.dart';

/// [currentUserDocunet] 는 항상 최신의 /users 사용자 정보를 가지고 있다.
UsersRecord? currentUserDocument;

/// 사용자 문서 정보 업데이트
///
/// 주의, 로그인 할 때 한 번만 /users 문서를 읽어, [currentUserDocument] 에 업데이트 한다.
/// 주의, 사용자의 /users 문서 정보 변경이 있을 때 마다, [currentUserDocument] 를 업데이트 하는 것이 아니다.
final authenticatedUserStream = FirebaseAuth.instance
    .authStateChanges()
    .map<String>((user) => user?.uid ?? '')
    .switchMap(
      (uid) => uid.isEmpty
          ? Stream.value(null)
          : UsersRecord.getDocument(UsersRecord.collection.doc(uid))
              .handleError((_) {}),
    )
    .map((user) => currentUserDocument = user)
    .asBroadcastStream();

/// 사용자가 로그인/로그아웃을 하면, 이 위젯을 다시 빌드한다.
///
/// 주의, 사용자 문서가 업데이트 할 때 마다 빌드하는 것이 아니다. MyDoc, PubDoc 을 참고한다.
class AuthUserStreamWidget extends StatelessWidget {
  const AuthUserStreamWidget({Key? key, required this.builder})
      : super(key: key);

  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: authenticatedUserStream,
        builder: (context, _) => builder(context),
      );
}
