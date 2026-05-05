import 'dart:math' as math;

import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/shapes/electric_shapes/electric_shape.dart';
import 'package:flutter/material.dart';

class PosteFibraVidroProjetadoSymbol extends ElectricShape {
  const PosteFibraVidroProjetadoSymbol({
    super.key,
    super.size = 180,
    super.color = const Color(0xFF2F3437),
    super.strokeWidth = 1,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: _PosteFibraDeVidroProjetadoPainter(
        color: color,
        strokeWidth: strokeWidth,
      ),
    );
  }

  @override
  ElectricShape copyWith({double? size, Color? color, double? strokeWidth}) {
    return PosteFibraVidroProjetadoSymbol(
      color: color ?? this.color,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      size: size ?? this.size,
    );
  }
}

class _PosteFibraDeVidroProjetadoPainter extends CustomPainter {
  _PosteFibraDeVidroProjetadoPainter({
    required this.color,
    this.strokeWidth,
  });

  final Color color;
  final double? strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.shortestSide;
    final stroke = strokeWidth ?? s * 0.045;

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final borderPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true;

    final center = Offset(size.width * 0.5, size.height * 0.5);

    final outerRadius = s * 0.39;
    final innerRadius = s * 0.16;

    final innerRect = Rect.fromCircle(center: center, radius: innerRadius);

    // Preenche somente a metade direita do círculo externo
    canvas.save();
    canvas.clipRect(Rect.fromLTRB(center.dx, 0, size.width, size.height));
    canvas.drawCircle(center, outerRadius, fillPaint);
    canvas.restore();

    // Contorno do círculo externo
    canvas.drawCircle(center, outerRadius, borderPaint);

    // Linha divisória vertical principal
    canvas.drawLine(
      Offset(center.dx, center.dy - outerRadius),
      Offset(center.dx, center.dy + outerRadius),
      borderPaint,
    );

    // Meia circunferência interna à esquerda
    final innerLeftSemiPath = Path()
      ..moveTo(center.dx, center.dy - innerRadius)
      ..arcTo(
        innerRect,
        -math.pi / 2,
        -math.pi,
        false,
      )
      ..lineTo(center.dx, center.dy + innerRadius)
      ..lineTo(center.dx, center.dy - innerRadius);

    canvas.drawPath(innerLeftSemiPath, borderPaint);
  }

  @override
  bool shouldRepaint(
      covariant _PosteFibraDeVidroProjetadoPainter oldDelegate,
      ) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}