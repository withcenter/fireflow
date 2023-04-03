import 'package:cached_network_image/cached_network_image.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.user,
    this.radius,
    this.padding = const EdgeInsets.all(0),
  });

  final UserModel user;
  final double? radius;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    if (user.photoUrl != null && user.photoUrl != '') {
      return Padding(
        padding: padding,
        child: CircleAvatar(
          radius: radius,
          backgroundImage: CachedNetworkImageProvider(user.photoUrl!),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
