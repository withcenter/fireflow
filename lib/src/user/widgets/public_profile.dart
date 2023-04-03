import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutterflow_widgets/flutterflow_widgets.dart';

/// 공개 프로필을 보여주는 위젯
///
/// [user] 또는 [userDocumentReference] 중 하나만 입력해야 한다.
/// 가능한 [user] 를 사용해서 빠르게 화면에 표시한다.
///
///
/// 예
/// ```dart
/// PublicProfile(user: user)
/// PublicProfile(userDocumentReference: user!.reference),
/// ```
class PublicProfile extends StatefulWidget {
  const PublicProfile({
    super.key,
    this.user,
    this.userDocumentReference,
  });

  final UserModel? user;
  final DocumentReference? userDocumentReference;

  @override
  State<PublicProfile> createState() => _PublicProfileState();
}

class _PublicProfileState extends State<PublicProfile> {
  UserModel? user;

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      user = widget.user;
    } else {
      UserService.instance.get(widget.userDocumentReference!.id).then((user) {
        setState(() {
          this.user = user;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) return const SizedBox.shrink();
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
              user?.photoUrl ?? 'https://via.placeholder.com/150',
            ),
          ),
          const SizedBox(height: 24),
          TextWithLabel(
            label: 'Display Name',
            text: user?.displayName ?? '',
          ),
          const SizedBox(height: 24),
          ElevatedButton(
              onPressed: () {
                dog('---- TODO: Follow ${user?.displayName} ----');
              },
              child: const Text('Follow'))
        ],
      ),
    );
  }
}
