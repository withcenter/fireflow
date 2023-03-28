import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutterflow_widgets/flutterflow_widgets.dart';

class PublicProfile extends StatelessWidget {
  const PublicProfile({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            radius: 64,
            backgroundImage: CachedNetworkImageProvider(
              user.photoUrl ?? 'https://via.placeholder.com/150',
            ),
          ),
          const SizedBox(height: 24),
          TextWithLabel(
            label: 'Display Name',
            text: user.displayName,
          ),
        ],
      ),
    );
  }
}
