import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/shapes/electric_shapes/electric_shape.dart';
import 'package:flutter/material.dart';

class ParaRaiosProjetadoSymbol extends ElectricShape {
  const ParaRaiosProjetadoSymbol({
    super.key,
    super.size = 180,
    super.color = const Color(0xFF2F3437),
    super.strokeWidth = 1,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size * 2.3, size),
      painter: _ParaRaiosProjetadoPainter(
        color: color,
        strokeWidth: strokeWidth,
      ),
    );
  }

  @override
  ElectricShape copyWith({double? size, Color? color, double? strokeWidth}) {
    return ParaRaiosProjetadoSymbol(
      color: color ?? this.color,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      size: size ?? this.size,
    );
  }
}

class _ParaRaiosProjetadoPainter extends CustomPainter {
  _ParaRaiosProjetadoPainter({
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

    final center = Offset(size.width * 0.18, size.height * 0.5);
    final radius = s * 0.42;

    // Círculo externo
    canvas.drawCircle(center, radius, paint);

    // Posição das linhas internas
    final x1 = center.dx - radius * 0.48; // pequena esquerda
    final x2 = center.dx - radius * 0.12; // alta esquerda-centro
    final x3 = center.dx + radius * 0.18; // pequena centro-direita
    final x4 = center.dx + radius * 0.47; // alta direita

    // Linha pequena esquerda
    canvas.drawLine(
      Offset(x1, center.dy - radius * 0.26),
      Offset(x1, center.dy + radius * 0.28),
      paint,
    );

    // Linha alta esquerda-centro
    canvas.drawLine(
      Offset(x2, center.dy - radius * 0.88),
      Offset(x2, center.dy + radius * 0.88),
      paint,
    );

    // Linha pequena centro-direita
    canvas.drawLine(
      Offset(x3, center.dy - radius * 0.26),
      Offset(x3, center.dy + radius * 0.26),
      paint,
    );

    // Linha alta direita
    canvas.drawLine(
      Offset(x4, center.dy - radius * 0.88),
      Offset(x4, center.dy + radius * 0.88),
      paint,
    );

    // Linha horizontal saindo para a direita
    canvas.drawLine(
      Offset(x4, center.dy),
      Offset(size.width * 0.96, center.dy),
      paint,
    );
  }

  @override
  bool shouldRepaint(
      covariant _ParaRaiosProjetadoPainter oldDelegate,
      ) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}