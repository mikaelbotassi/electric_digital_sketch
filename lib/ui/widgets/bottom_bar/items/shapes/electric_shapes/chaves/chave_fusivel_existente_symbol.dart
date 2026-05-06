import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/shapes/electric_shapes/electric_shape.dart';
import 'package:flutter/material.dart';

class ChaveFusivelExistenteSymbol extends ElectricShape {
  const ChaveFusivelExistenteSymbol({
    super.key,
    super.size = 180,
    super.color = const Color(0xFF2F3437),
    super.strokeWidth = 1,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size * 2.6, size),
      painter: _ChaveFusivelExistentePainter(
        color: color,
        strokeWidth: strokeWidth,
      ),
    );
  }

  @override
  ElectricShape copyWith({double? size, Color? color, double? strokeWidth}) {
    return ChaveFusivelExistenteSymbol(
      color: color ?? this.color,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      size: size ?? this.size,
    );
  }
}

class _ChaveFusivelExistentePainter extends CustomPainter {
  _ChaveFusivelExistentePainter({
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

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final centerY = size.height * 0.50;

    final leftPivot = Offset(size.width * 0.20, centerY);
    final rightContact = Offset(size.width * 0.52, centerY);

    // Linha horizontal da esquerda
    canvas..drawLine(
      Offset(size.width * 0.04, centerY),
      leftPivot,
      strokePaint,
    )

    // Linha horizontal da direita
    ..drawLine(
      rightContact,
      Offset(size.width * 0.96, centerY),
      strokePaint,
    )

    // Pontos de contato
    ..drawCircle(leftPivot, stroke * 0.95, fillPaint)
    ..drawCircle(rightContact, stroke * 0.95, fillPaint);

    // Haste diagonal principal
    final diagonalEnd = Offset(
      size.width * 0.44,
      size.height * 0.74,
    );

    canvas.drawLine(
      leftPivot,
      diagonalEnd,
      strokePaint,
    );

    // Curva superior do fusível
    final upperCurve = Path()
      ..moveTo(leftPivot.dx + stroke * 0.4, leftPivot.dy)
      ..quadraticBezierTo(
        size.width * 0.29,
        size.height * 0.27,
        size.width * 0.33,
        size.height * 0.56,
      );

    // Curva inferior do fusível
    final lowerCurve = Path()
      ..moveTo(size.width * 0.31, size.height * 0.54)
      ..quadraticBezierTo(
        size.width * 0.34,
        size.height * 0.78,
        diagonalEnd.dx,
        diagonalEnd.dy,
      );

    canvas..drawPath(upperCurve, strokePaint)
    ..drawPath(lowerCurve, strokePaint);
  }

  @override
  bool shouldRepaint(
      covariant _ChaveFusivelExistentePainter oldDelegate,
      ) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}