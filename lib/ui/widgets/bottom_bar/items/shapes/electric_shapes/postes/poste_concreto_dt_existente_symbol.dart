import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/shapes/electric_shapes/electric_shape.dart';
import 'package:flutter/material.dart';

class PosteConcretoDtExistenteSymbol extends ElectricShape {
  const PosteConcretoDtExistenteSymbol({
    super.key,
    super.size = 48,
    super.color = const Color(0xFF2F3437),
    super.strokeWidth = 1,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: _RetanguloCurvasLateraisPainter(
        color: color,
        strokeWidth: strokeWidth,
      ),
    );
  }

  @override
  ElectricShape copyWith({double? size, Color? color, double? strokeWidth}) {
    return PosteConcretoDtExistenteSymbol(
      color: color ?? this.color,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      size: size ?? this.size,
    );
  }
}

class _RetanguloCurvasLateraisPainter extends CustomPainter {
  _RetanguloCurvasLateraisPainter({
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

    final left = size.width * 0.12;
    final top = size.height * 0.10;
    final right = size.width * 0.88;
    final bottom = size.height * 0.90;
    final midY = (top + bottom) / 2;

    // Quadrado externo
    final outerRect = Rect.fromLTRB(left, top, right, bottom);
    canvas.drawRect(outerRect, paint);

    // Curva interna esquerda
    final leftCurve = Path()
      ..moveTo(left, top)
      ..quadraticBezierTo(
        size.width * 0.42,
        midY,
        left,
        bottom,
      );

    // Curva interna direita
    final rightCurve = Path()
      ..moveTo(right, top)
      ..quadraticBezierTo(
        size.width * 0.58,
        midY,
        right,
        bottom,
      );

    canvas.drawPath(leftCurve, paint);
    canvas.drawPath(rightCurve, paint);
  }

  @override
  bool shouldRepaint(
      covariant _RetanguloCurvasLateraisPainter oldDelegate,
      ) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}