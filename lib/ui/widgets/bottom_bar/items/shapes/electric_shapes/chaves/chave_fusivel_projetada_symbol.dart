import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/shapes/electric_shapes/electric_shape.dart';
import 'package:flutter/material.dart';

class ChaveFusivelProjetadaSymbol extends ElectricShape {
  const ChaveFusivelProjetadaSymbol({
    super.key,
    super.size = 180,
    super.color = const Color(0xFF2F3437),
    super.strokeWidth = 1,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size * 2.6, size),
      painter: _ChaveFusivelProjetadaPainter(
        color: color,
        strokeWidth: strokeWidth,
      ),
    );
  }

  @override
  ElectricShape copyWith({double? size, Color? color, double? strokeWidth}) {
    return ChaveFusivelProjetadaSymbol(
      color: color ?? this.color,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      size: size ?? this.size,
    );
  }
}

class _ChaveFusivelProjetadaPainter extends CustomPainter {
  _ChaveFusivelProjetadaPainter({
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

    final center = Offset(size.width * 0.34, size.height * 0.50);
    final radius = s * 0.36;

    final leftPivot = Offset(center.dx - radius * 0.64, center.dy);
    final rightContact = Offset(center.dx + radius * 0.44, center.dy);

    // Círculo externo
    canvas..drawCircle(center, radius, strokePaint)

    // Linha horizontal da esquerda
    ..drawLine(
      Offset(size.width * 0.04, center.dy),
      leftPivot,
      strokePaint,
    )

    // Linha horizontal da direita
    ..drawLine(
      rightContact,
      Offset(size.width * 0.97, center.dy),
      strokePaint,
    )

    // Pontos de conexão
    ..drawCircle(leftPivot, stroke * 0.95, fillPaint)
    ..drawCircle(rightContact, stroke * 0.95, fillPaint);

    // Haste diagonal interna
    final diagonalEnd = Offset(
      center.dx + radius * 0.36,
      center.dy + radius * 0.54,
    );

    canvas.drawLine(
      leftPivot,
      diagonalEnd,
      strokePaint,
    );

    // Curva interna superior
    final upperCurve = Path()
      ..moveTo(leftPivot.dx + stroke * 0.4, leftPivot.dy)
      ..quadraticBezierTo(
        center.dx - radius * 0.05,
        center.dy - radius * 0.38,
        center.dx + radius * 0.05,
        center.dy - radius * 0.03,
      );

    // Curva interna inferior
    final lowerCurve = Path()
      ..moveTo(center.dx - radius * 0.02, center.dy + radius * 0.02)
      ..quadraticBezierTo(
        center.dx + radius * 0.10,
        center.dy + radius * 0.45,
        diagonalEnd.dx,
        diagonalEnd.dy,
      );

    canvas..drawPath(upperCurve, strokePaint)
    ..drawPath(lowerCurve, strokePaint);
  }

  @override
  bool shouldRepaint(
      covariant _ChaveFusivelProjetadaPainter oldDelegate,
      ) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
