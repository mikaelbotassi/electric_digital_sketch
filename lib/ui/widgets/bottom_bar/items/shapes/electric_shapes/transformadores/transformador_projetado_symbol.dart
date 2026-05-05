import 'package:flutter/material.dart';

class TransformadorProjetadoSymbol extends StatelessWidget {
  const TransformadorProjetadoSymbol({
    super.key,
    this.size = 180,
    this.color = const Color(0xFF2F3437),
    this.strokeWidth,
  });

  final double size;
  final Color color;
  final double? strokeWidth;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: _CircleTrianglePainter(
        color: color,
        strokeWidth: strokeWidth,
      ),
    );
  }
}

class _CircleTrianglePainter extends CustomPainter {
  _CircleTrianglePainter({
    required this.color,
    this.strokeWidth,
  });

  final Color color;
  final double? strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.shortestSide;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth ?? s * 0.045
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true;

    final center = Offset(size.width * 0.5, size.height * 0.52);

    final radius = s * 0.42;

    canvas.drawCircle(
      center,
      radius,
      paint,
    );

    final trianglePath = Path()
      ..moveTo(size.width * 0.52, size.height * 0.20)
      ..lineTo(size.width * 0.27, size.height * 0.70)
      ..lineTo(size.width * 0.76, size.height * 0.69)
      ..close();

    canvas.drawPath(trianglePath, paint);
  }

  @override
  bool shouldRepaint(covariant _CircleTrianglePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}