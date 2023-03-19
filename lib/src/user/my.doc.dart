import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

/// MyDoc is a stream builder that represents a user public data document.
///
/// It is a wrapper around StreamBuilder that listens to changes in the user.
/// Use this widget to display user information.
///
/// TODO this should be changed into `MyPubDoc` and create a `MyDoc` with user model.
class MyDoc extends StatelessWidget {
  const MyDoc({Key? key, required this.builder}) : super(key: key);

  final Widget Function(UserPublicDataModel my) builder;

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

          return builder(snapshot.data as UserPublicDataModel);
        });
  }
}
