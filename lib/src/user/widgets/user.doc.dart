import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

/// 다른 사용자 문서를 리턴하거나 listen 한다.
///
/// 주의, 이 위젯은 사용자 문서를 메모리에 캐시한다. 그래서 [isLive] 가 false 이면, 사용자 문서가 변경되어도
/// 이 위젯은 변경된 내용을 보여주지 않는다. 즉, 한번만 사용자 문서를 읽어서, 위젯을 빌드 한다.
///
/// [isLive] 가 true 이면, 사용자 문서가 변경되면 rebuild 를 해서, 변경된 내용으로 위젯을 빌드 할 수 있다.
class UserDoc extends StatefulWidget {
  const UserDoc({
    Key? key,
    required this.reference,
    required this.builder,
    this.isLive = false,
  }) : super(key: key);

  final DocumentReference reference;
  final Widget Function(UserModel other) builder;
  final bool isLive;

  @override
  State<UserDoc> createState() => _UserDocState();
}

class _UserDocState extends State<UserDoc> {
  UserModel? user;
  StreamSubscription? _subscription;
  @override
  void initState() {
    super.initState();
    if (widget.isLive) {
      _listen();
    } else {
      _read();
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return user == null ? const SizedBox.shrink() : widget.builder(user!);
  }

  /// 사용자 문서를 읽어서, [user] 에 저장한다. 캐시된 사용자 문서 일 수 있다.
  Future<void> _read() async {
    final got = await UserService.instance.get(widget.reference.id);

    if (mounted) {
      setState(() {
        user = got;
      });
    }
  }

  /// 사용자 문서를 listen 한다. 실시간 업데이트되는 사용자 정보를 받아서, rebuild 한다.
  _listen() {
    _subscription = widget.reference.snapshots().listen((doc) {
      // if (doc.exists == false) {
      //   dog('---> UserDoc() does not exists; ${widget.reference.path}');
      //   return;
      // }
      if (mounted) {
        setState(() {
          user = UserModel.fromSnapshot(doc);

          /// 실시간으로 가져온 정보를 캐시에 업데이트.
          UserService.instance.updateUserModelCache(user!);
        });
      }
    });
  }
}
