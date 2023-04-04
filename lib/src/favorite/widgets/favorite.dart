import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

/// 즐겨찾기 위젯
///
/// 즐겨찾기를 했는지 하지 않았는지를 바탕으로 자식 위젯을 빌드 할 수 있도록 해 준다.
/// [targetDocumentReference] 로 문서를 읽어, 즐겨찾기를 했는지 하지 않았는지를 판단.
/// 즐겨찾기가 존재하면, true. 아니면 false 를 [builder] 로 전달.
///
class Favorite extends StatelessWidget {
  const Favorite({
    Key? key,
    required this.targetDocumentReference,
    required this.builder,
  }) : super(key: key);
  final DocumentReference targetDocumentReference;
  final Widget Function(bool isFavorite) builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            FavoriteService.instance.query(targetDocumentReference).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox.shrink();
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return builder(false);
          } else {
            final QuerySnapshot querySnapshot = snapshot.data as QuerySnapshot;
            if (querySnapshot.docs.isEmpty) {
              return builder(false);
            } else {
              return builder(true);
            }
          }
        });
  }
}
