import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/shapes/electric_shapes/electric_shape.dart';
import 'package:flutter/material.dart';

class ChaveReligadoraProjetadaSymbol extends ElectricShape {
  const ChaveReligadoraProjetadaSymbol({
    super.key,
    super.size = 180,
    super.color = const Color(0xFF2F3437),
    super.strokeWidth = 1,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size * 2.4, size),
      painter: _ChaveReligadoraProjetadaPainter(
        color: color,
        strokeWidth: strokeWidth,
      ),
    );
  }

  @override
  ElectricShape copyWith({double? size, Color? color, double? strokeWidth}) {
    return ChaveReligadoraProjetadaSymbol(
      color: color ?? this.color,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      size: size ?? this.size,
    );
  }
}

class _ChaveReligadoraProjetadaPainter extends CustomPainter {
  _ChaveReligadoraProjetadaPainter({
    required this.color,
    this.strokeWidth,
  });

  final Color color;
  final double? strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.height;
    final stroke = strokeWidth ?? s * 0.045;

    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true;

    final center = Offset(size.width * 0.23, size.height * 0.5);
    final radius = s * 0.42;

    // Círculo externo
    canvas.drawCircle(center, radius, strokePaint);

    // Quadrado interno
    final rect = Rect.fromLTWH(
      center.dx - radius * 0.62,
      center.dy - radius * 0.58,
      radius * 1.28,
      radius * 1.16,
    );

    canvas..drawRect(rect, strokePaint)

    // Linha horizontal saindo à direita
    ..drawLine(
      Offset(rect.right, center.dy),
      Offset(size.width * 0.96, center.dy),
      strokePaint,
    );

    // Texto "RL"
    final textPainter = TextPainter(
      text: TextSpan(
        text: 'RL',
        style: TextStyle(
          color: color,
          fontSize: radius * 0.72,
          fontWeight: FontWeight.w500,
          height: 1,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout();

    final textOffset = Offset(
      rect.center.dx - textPainter.width / 2,
      rect.center.dy - textPainter.height / 2,
    );

    textPainter.paint(canvas, textOffset);
  }

  @override
  bool shouldRepaint(
      covariant _ChaveReligadoraProjetadaPainter oldDelegate,
      ) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
