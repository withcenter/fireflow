import 'package:cached_network_image/cached_network_image.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.user,
    this.size = 40,
    this.padding = const EdgeInsets.all(0),
    this.border,
    this.borderColor = Colors.white,
  });

  final UserModel user;
  final double size;
  final EdgeInsets padding;

  final double? border;
  final Color borderColor;

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
            border: border == null
                ? null
                : Border.all(
                    color: borderColor,
                    width: border!,
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
              (user.displayName == ""
                      ? user.uid.substring(0, 2)
                      : user.displayName)
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
