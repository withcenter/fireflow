import 'package:cached_network_image/cached_network_image.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.user,
    this.size = 48,
    this.padding = const EdgeInsets.all(0),
  });

  final UserModel user;
  final double size;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    if (user.photoUrl != null && user.photoUrl != '') {
      return Padding(
        padding: padding,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: CachedNetworkImageProvider(user.photoUrl!),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: padding,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.brown.shade800,
          ),
          child: Center(
            child: Text(
              (user.displayName == "" ? "NA" : user.displayName)
                  .substring(0, 2)
                  .toUpperCase(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    }
  }
}
