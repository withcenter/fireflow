import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

/// 내 정보를 실시간 업데이트 해서 보여주는 위젯
///
/// 참고, MyDoc 은 사용자가 로그인을 했을 때에만 사용 가능하다.
/// 로그인 하지 않았으면 빈 위젯이 표시된다. 즉, 화면에 아무것도 나타나지 않는다.
///
/// 로그인 했을 때와 로그아웃 했을 때, 다르게 보여주고 싶다면, AuthStream 위젯을 사용한다.
class MyDoc extends StatelessWidget {
  const MyDoc({Key? key, required this.builder}) : super(key: key);

  final Widget Function(UserModel my) builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: UserService.instance.onMyChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox.shrink();
        }
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return const SizedBox.shrink();
        }

        return builder(snapshot.data as UserModel);
      },
    );
  }
}
