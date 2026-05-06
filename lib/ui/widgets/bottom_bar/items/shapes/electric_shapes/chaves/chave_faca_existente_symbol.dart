import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/shapes/electric_shapes/electric_shape.dart';
import 'package:flutter/material.dart';

class ChaveFacaExistenteSymbol extends ElectricShape {
  const ChaveFacaExistenteSymbol({
    super.key,
    super.size = 180,
    super.color = const Color(0xFF2F3437),
    super.strokeWidth = 1,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size * 2.5, size),
      painter: _ChaveFacaExistentePainter(
        color: color,
        strokeWidth: strokeWidth,
      ),
    );
  }

  @override
  ElectricShape copyWith({double? size, Color? color, double? strokeWidth}) {
    return ChaveFacaExistenteSymbol(
      color: color ?? this.color,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      size: size ?? this.size,
    );
  }
}

class _ChaveFacaExistentePainter extends CustomPainter {
  _ChaveFacaExistentePainter({
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

    final leftPivot = Offset(size.width * 0.34, centerY);
    final rightContact = Offset(size.width * 0.56, centerY);

    // Linha horizontal da esquerda até o pivô
    canvas.drawLine(
      Offset(size.width * 0.06, centerY),
      leftPivot,
      strokePaint,
    );

    // Ponto de articulação esquerdo
    canvas.drawCircle(leftPivot, stroke * 0.95, fillPaint);

    // Ponto de contato à direita
    canvas.drawCircle(rightContact, stroke * 0.95, fillPaint);

    // Linha horizontal saindo para a direita
    canvas.drawLine(
      rightContact,
      Offset(size.width * 0.95, centerY),
      strokePaint,
    );

    // Haste diagonal ("faca")
    final bladeEnd = Offset(
      size.width * 0.51,
      size.height * 0.73,
    );

    canvas.drawLine(
      leftPivot,
      bladeEnd,
      strokePaint,
    );

    // Pequeno segmento na ponta da faca
    canvas.drawLine(
      bladeEnd,
      Offset(
        bladeEnd.dx - size.width * 0.05,
        bladeEnd.dy + size.height * 0.05,
      ),
      strokePaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ChaveFacaExistentePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}