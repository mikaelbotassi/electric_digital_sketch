import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/shapes/electric_shapes/electric_shape.dart';
import 'package:flutter/material.dart';

class ParaRaiosExistenteSymbol extends ElectricShape {
  const ParaRaiosExistenteSymbol({
    super.key,
    super.size = 180,
    super.color = const Color(0xFF2F3437),
    super.strokeWidth = 1,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size * 2.3, size),
      painter: _ParaRaiosExistentePainter(
        color: color,
        strokeWidth: strokeWidth,
      ),
    );
  }

  @override
  ElectricShape copyWith({double? size, Color? color, double? strokeWidth}) {
    return ParaRaiosExistenteSymbol(
      color: color ?? this.color,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      size: size ?? this.size,
    );
  }
}

class _ParaRaiosExistentePainter extends CustomPainter {
  _ParaRaiosExistentePainter({
    required this.color,
    this.strokeWidth,
  });

  final Color color;
  final double? strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.height;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth ?? s * 0.045
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true;

    final centerY = size.height * 0.5;

    final x1 = size.width * 0.06; // pequena esquerda
    final x2 = size.width * 0.16; // alta esquerda-centro
    final x3 = size.width * 0.26; // pequena centro-direita
    final x4 = size.width * 0.36; // alta direita

    // Linha pequena esquerda
    canvas.drawLine(
      Offset(x1, size.height * 0.30),
      Offset(x1, size.height * 0.70),
      paint,
    );

    // Linha alta esquerda-centro
    canvas.drawLine(
      Offset(x2, size.height * 0.08),
      Offset(x2, size.height * 0.92),
      paint,
    );

    // Linha pequena centro-direita
    canvas.drawLine(
      Offset(x3, size.height * 0.30),
      Offset(x3, size.height * 0.70),
      paint,
    );

    // Linha alta direita
    canvas.drawLine(
      Offset(x4, size.height * 0.08),
      Offset(x4, size.height * 0.92),
      paint,
    );

    // Linha horizontal saindo para a direita
    canvas.drawLine(
      Offset(x4, centerY),
      Offset(size.width * 0.97, centerY),
      paint,
    );
  }

  @override
  bool shouldRepaint(
      covariant _ParaRaiosExistentePainter oldDelegate,
      ) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}