import 'package:flutter/cupertino.dart';

class HorizontalLinePainter extends CustomPainter {
  HorizontalLinePainter({
    required this.color,
    required this.strokeWidth,
    required this.isDashed,
  });

  final Color color;
  final double? strokeWidth;
  final bool isDashed;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = strokeWidth ?? 1;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true;

    final y = size.height * 0.5;
    final startX = size.width * 0.04;
    final endX = size.width * 0.96;

    if (!isDashed) {
      canvas.drawLine(
        Offset(startX, y),
        Offset(endX, y),
        paint,
      );
      return;
    }

    final dashLength = size.width * 0.16;
    final dashGap = size.width * 0.07;

    var currentX = startX;

    while (currentX < endX) {
      final nextX = (currentX + dashLength).clamp(startX, endX);

      canvas.drawLine(
        Offset(currentX, y),
        Offset(nextX, y),
        paint,
      );

      currentX += dashLength + dashGap;
    }
  }

  @override
  bool shouldRepaint(covariant HorizontalLinePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.isDashed != isDashed;
  }
}
