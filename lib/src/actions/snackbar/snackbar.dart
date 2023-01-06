import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

class CustomStyleArrow extends CustomPainter {
  CustomStyleArrow({
    required this.color,
  });
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.fill;
    const double triangleH = 5;
    const double triangleW = 10.0;
    final double width = size.width;
    final double height = size.height;

    final Path trianglePath = Path()
      ..moveTo(width / 2 - triangleW / 2, height)
      ..lineTo(width / 2, triangleH + height)
      ..lineTo(width / 2 + triangleW / 2, height)
      ..lineTo(width / 2 - triangleW / 2, height);
    canvas.drawPath(trianglePath, paint);
    final BorderRadius borderRadius = BorderRadius.circular(8);
    final Rect rect = Rect.fromLTRB(0, 0, width, height);
    final RRect outer = borderRadius.toRRect(rect);
    canvas.drawRRect(outer, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

SnackBar snackBarContent({
  required String title,
  required String message,
  Color backgroundColor = Colors.black,
  Icon icon = const Icon(Icons.check_circle, color: Colors.amber, size: 28),
  Color closeButtonColor = Colors.amber,
  Color arrowBackgroundColor = Colors.white,
  int? seconds,
}) {
  Widget content = SizedBox(
    height: 100,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          height: 64,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    message,
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                ScaffoldMessenger.of(AppService.instance.context)
                    .hideCurrentSnackBar();
              },
              icon: Icon(
                Icons.close,
                color: closeButtonColor,
              ),
            ),
          ]),
        ),
        Positioned(
          left: 16,
          top: -8,
          child: CustomPaint(
            painter: CustomStyleArrow(color: arrowBackgroundColor),
            child: Container(
              padding: const EdgeInsets.all(4),
              child: icon,
            ),
          ),
        ),
      ],
    ),
  );

  return SnackBar(
    backgroundColor: Colors.transparent,
    behavior: SnackBarBehavior.floating,
    elevation: 0,
    duration: Duration(seconds: seconds ?? 10),
    content: content,
  );
}

/// show a modal on top.
///
/// showModalTopSheet is a custom action that shows a modal top sheet.
/// It can be used to display a snackbar on top.
snackBarSuccess({
  required String title,
  required String message,
  int? seconds,
}) {
  ScaffoldMessenger.of(AppService.instance.context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      snackBarContent(
        title: title,
        message: message,
        backgroundColor: Colors.black,
        closeButtonColor: Colors.amber,
        icon: const Icon(Icons.check_circle, color: Colors.green, size: 28),
        arrowBackgroundColor: Colors.white,
        seconds: seconds,
      ),
    );
}

/// show a modal on top.
///
/// showModalTopSheet is a custom action that shows a modal top sheet.
/// It can be used to display a snackbar on top.
snackBarWarning({
  required String title,
  required String message,
  int? seconds,
}) {
  ScaffoldMessenger.of(AppService.instance.context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      snackBarContent(
        title: title,
        message: message,
        backgroundColor: Colors.amber.shade700,
        closeButtonColor: Colors.white,
        icon: Icon(Icons.error, color: Colors.amber.shade800, size: 28),
        arrowBackgroundColor: Colors.white,
        seconds: seconds,
      ),
    );
}
