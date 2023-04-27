import 'package:flutter/material.dart';

/// 날짜/시간을 짧게 표시하는 위젯
class ShortDateTime extends StatelessWidget {
  const ShortDateTime({
    super.key,
    required this.dateTime,
    this.style,
  });

  final DateTime dateTime;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    String text;
    if (dateTime.year == DateTime.now().year &&
        dateTime.month == DateTime.now().month &&
        dateTime.day == DateTime.now().day) {
      /// AM 또는 PM 으로 나누어서 text 변수에 저장
      text = dateTime.hour > 12
          ? '${dateTime.hour - 12}:${dateTime.minute} PM'
          : '${dateTime.hour}:${dateTime.minute} AM';
    } else {
      text = "${dateTime.year}-${dateTime.month}-${dateTime.day}";
    }

    return Text(text, style: style);
  }
}
