import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

/// PubDoc is a stream builder that represents a user public data document.
///
/// It is a wrapper around StreamBuilder that listens to changes in the user.
/// Use this widget to display user information.
///
/// 최신 사용자 데이터는 AppService.instance.pub 에 저장되어 있다.
class PubDoc extends StatelessWidget {
  const PubDoc({Key? key, required this.builder}) : super(key: key);

  final Widget Function(UsersPublicDataRecord pub) builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: UserService.instance.onPubChange,
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

          return builder(snapshot.data as UsersPublicDataRecord);
        });
  }
}
