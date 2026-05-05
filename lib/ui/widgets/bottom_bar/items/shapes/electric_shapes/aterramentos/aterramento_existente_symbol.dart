import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/shapes/electric_shapes/electric_shape.dart';
import 'package:flutter/material.dart';

class AterramentoExistenteSymbol extends ElectricShape {
  const AterramentoExistenteSymbol({
    super.key,
    super.size = 180,
    super.color = const Color(0xFF2F3437),
    super.strokeWidth = 1,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size * 2.1, size),
      painter: _AterramentoExistentePainter(
        color: color,
        strokeWidth: strokeWidth,
      ),
    );
  }

  @override
  ElectricShape copyWith({double? size, Color? color, double? strokeWidth}) {
    return AterramentoExistenteSymbol(
      color: color ?? this.color,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      size: size ?? this.size,
    );
  }
}

class _AterramentoExistentePainter extends CustomPainter {
  _AterramentoExistentePainter({
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

    final x1 = size.width * 0.06;
    final x2 = size.width * 0.18;
    final x3 = size.width * 0.30;

    // Linha vertical esquerda (menor)
    canvas.drawLine(
      Offset(x1, size.height * 0.32),
      Offset(x1, size.height * 0.68),
      paint,
    );

    // Linha vertical central (média)
    canvas.drawLine(
      Offset(x2, size.height * 0.22),
      Offset(x2, size.height * 0.78),
      paint,
    );

    // Linha vertical direita (maior)
    canvas.drawLine(
      Offset(x3, size.height * 0.08),
      Offset(x3, size.height * 0.92),
      paint,
    );

    // Linha horizontal saindo para a direita
    canvas.drawLine(
      Offset(x3, centerY),
      Offset(size.width * 0.95, centerY),
      paint,
    );
  }

  @override
  bool shouldRepaint(
      covariant _AterramentoExistentePainter oldDelegate,
      ) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}