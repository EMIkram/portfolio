import 'package:flutter/material.dart';

class GitHubIcon extends StatelessWidget {
  const GitHubIcon({super.key});

  @override
  Widget build(BuildContext context) => CustomPaint(
    size: const Size.square(20),
    painter: _GitHubMark(Theme.of(context).colorScheme.onSurface),
  );
}

class _GitHubMark extends CustomPainter {
  const _GitHubMark(this.color);
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(size.width / 24, size.height / 24);
    final path = Path()
      ..moveTo(12, 0.5)
      ..cubicTo(5.65, 0.5, 0.5, 5.65, 0.5, 12)
      ..cubicTo(0.5, 17.08, 3.79, 21.39, 8.36, 22.91)
      ..cubicTo(8.94, 23.02, 9.15, 22.66, 9.15, 22.35)
      ..lineTo(9.15, 20.21)
      ..cubicTo(5.95, 20.91, 5.28, 18.85, 5.28, 18.85)
      ..cubicTo(4.76, 17.52, 4, 17.16, 4, 17.16)
      ..cubicTo(2.96, 16.45, 4.08, 16.46, 4.08, 16.46)
      ..cubicTo(5.23, 16.54, 5.83, 17.64, 5.83, 17.64)
      ..cubicTo(6.85, 19.39, 8.52, 18.89, 9.18, 18.6)
      ..cubicTo(9.28, 17.86, 9.58, 17.35, 9.91, 17.06)
      ..cubicTo(7.35, 16.77, 4.66, 15.78, 4.66, 11.37)
      ..cubicTo(4.66, 10.11, 5.11, 9.08, 5.85, 8.27)
      ..cubicTo(5.73, 7.98, 5.33, 6.81, 5.97, 5.22)
      ..cubicTo(5.97, 5.22, 6.94, 4.91, 9.13, 6.4)
      ..cubicTo(10.04, 6.15, 10.99, 6.02, 12, 6.02)
      ..cubicTo(13.01, 6.02, 13.96, 6.15, 14.87, 6.4)
      ..cubicTo(17.06, 4.91, 18.03, 5.22, 18.03, 5.22)
      ..cubicTo(18.67, 6.81, 18.27, 7.98, 18.15, 8.27)
      ..cubicTo(18.89, 9.08, 19.34, 10.11, 19.34, 11.37)
      ..cubicTo(19.34, 15.79, 16.64, 16.77, 14.07, 17.06)
      ..cubicTo(14.48, 17.42, 14.85, 18.12, 14.85, 19.19)
      ..lineTo(14.85, 22.35)
      ..cubicTo(14.85, 22.66, 15.06, 23.02, 15.64, 22.91)
      ..cubicTo(20.21, 21.39, 23.5, 17.08, 23.5, 12)
      ..cubicTo(23.5, 5.65, 18.35, 0.5, 12, 0.5)
      ..close();
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_GitHubMark oldDelegate) => oldDelegate.color != color;
}
