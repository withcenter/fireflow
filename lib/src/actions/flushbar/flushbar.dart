import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

showFlushbar({
  required String title,
  required String message,
  Function? onTap,
  int seconds = 10,
}) {
  late Flushbar flush;
  flush = Flushbar(
    flushbarPosition: FlushbarPosition.TOP,
    margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
    borderRadius: BorderRadius.circular(16),
    title: title,
    message: message,
    duration: Duration(seconds: seconds),
    mainButton: IconButton(
      icon: Icon(Icons.close, color: Colors.white.withAlpha(150)),
      onPressed: () {
        dog('onPressed');
        flush.dismiss();
      },
    ),
    onTap: (flushbar) {
      if (onTap != null) onTap();
      flushbar.dismiss();
    },
  )..show(AppService.instance.context);
}
