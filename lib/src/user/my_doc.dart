import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

/// MyDoc is a stream builder that build with the latest /users document.
///
/// It is a wrapper around StreamBuilder that listens to changes to the user document.
/// Use this widget to display user information.
///
///
/// 최신 사용자 데이터는 AppService.instance.my 에 저장되어 있다.
class MyDoc extends StatelessWidget {
  const MyDoc({Key? key, required this.builder}) : super(key: key);

  final Widget Function(UsersRecord my) builder;

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

          return builder(snapshot.data as UsersRecord);
        });
  }
}
