import 'package:fireflow/fireflow.dart';
import 'package:flutter/widgets.dart';

/// 사용자 문서가 변할 때 마다 위젯을 빌드
///
/// 주의, 사용자 문서가 업데이트 할 때 마다 빌드하는 것이다.
/// 원칙은 로그인/로그아웃 할 때 마다 빌드하는 것이 아니지만, 로그인/로그아웃 할 때,
/// UserService.instance.onMyChange 가 호출되므로, 로그인/로그아웃 할 때 마다 같이 빌드된다.
///
/// 특히, 이 함수가 유용한 이유는 authStateChanges() 를 listen 하면, 사용자 문서가 아직, 준비되지 않았을 수 있는데,
/// 이 함수는 사용자 문서가 준비된 후, 빌드한다.
class MyStream extends StatelessWidget {
  const MyStream({Key? key, this.login, this.logout}) : super(key: key);

  final Widget Function(UsersRecord my)? login;
  final Widget Function()? logout;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: UserService.instance.onMyChange,
        builder: (context, snapshot) {
          if (UserService.instance.notLoggedIn) {
            if (logout == null) {
              return const SizedBox.shrink();
            } else {
              return logout!();
            }
          }

          if (login == null) {
            return const SizedBox.shrink();
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox.shrink();
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const SizedBox.shrink();
          }

          return login!(snapshot.data as UsersRecord);
        });
  }
}
