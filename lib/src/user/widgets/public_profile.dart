import 'package:flutter/material.dart';
import 'package:fireflow/fireflow.dart';

class PublicProfile extends StatelessWidget {
  const PublicProfile({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          radius: 64,
          backgroundImage: NetworkImage(
            user.photoUrl ?? 'https://via.placeholder.com/150',
          ),
        ),
        const SizedBox(height: 24),
        TextWithLabel(
          label: 'Display Name',
          text: user.displayName,
        ),
      ],
    );
  }
}
