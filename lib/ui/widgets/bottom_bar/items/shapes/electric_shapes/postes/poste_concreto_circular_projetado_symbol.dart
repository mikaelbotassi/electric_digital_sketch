import 'dart:ui' as ui;
import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/shapes/electric_shapes/electric_shape.dart';
import 'package:flutter/material.dart';

class PosteConcretoCircularProjetadoSymbol extends ElectricShape {
  const PosteConcretoCircularProjetadoSymbol({
    super.key,
    super.size = 48,
    super.color = const Color(0xFF2F3437),
    super.strokeWidth = 1,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: _PosteConcretoCircularProjetadoPainter(
        color: color,
        strokeWidth: strokeWidth,
      ),
    );
  }

  @override
  ElectricShape copyWith({double? size, Color? color, double? strokeWidth}) {
    return PosteConcretoCircularProjetadoSymbol(
      color: color ?? this.color,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      size: size ?? this.size,
    );
  }
}

class _PosteConcretoCircularProjetadoPainter extends CustomPainter {
  _PosteConcretoCircularProjetadoPainter({
    required this.color,
    this.strokeWidth,
  });

  final Color color;
  final double? strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.shortestSide;
    final stroke = strokeWidth ?? s * 0.045;

    final center = Offset(size.width * 0.5, size.height * 0.5);
    final outerRadius = s * 0.39;
    final innerRadius = s * 0.16;

    final outerRect = Rect.fromCircle(center: center, radius: outerRadius);
    final innerRect = Rect.fromCircle(center: center, radius: innerRadius);

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

    final clearPaint = Paint()
      ..blendMode = BlendMode.clear
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    canvas.saveLayer(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint(),
    );

    // 1) Desenha o círculo externo preenchido
    canvas.drawCircle(center, outerRadius, fillPaint);

    // 2) Limpa o círculo interno, formando o anel
    canvas.drawCircle(center, innerRadius, clearPaint);

    // 3) Limpa a metade esquerda do anel, deixando só a metade direita preenchida
    final leftHalfPath = Path()
      ..addRect(Rect.fromLTRB(0, 0, center.dx, size.height));

    final outerPath = Path()..addOval(outerRect);
    final innerPath = Path()..addOval(innerRect);

    final ringPath = Path.combine(
      ui.PathOperation.difference,
      outerPath,
      innerPath,
    );

    final leftHalfRingPath = Path.combine(
      ui.PathOperation.intersect,
      ringPath,
      leftHalfPath,
    );

    canvas.drawPath(leftHalfRingPath, clearPaint);

    // 4) Contornos
    canvas.drawCircle(center, outerRadius, borderPaint);
    canvas.drawCircle(center, innerRadius, borderPaint);

    // 5) Linha divisória central (parte superior e inferior)
    final outerTopY = center.dy - outerRadius;
    final innerTopY = center.dy - innerRadius;
    final innerBottomY = center.dy + innerRadius;
    final outerBottomY = center.dy + outerRadius;

    canvas.drawLine(
      Offset(center.dx, outerTopY),
      Offset(center.dx, innerTopY),
      borderPaint,
    );

    canvas.drawLine(
      Offset(center.dx, innerBottomY),
      Offset(center.dx, outerBottomY),
      borderPaint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(
      covariant _PosteConcretoCircularProjetadoPainter oldDelegate,
      ) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}