import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/shapes/electric_shapes/electric_shape.dart';
import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/shapes/electric_shapes/redes/horizontal_line_painter.dart';
import 'package:flutter/material.dart';

class RedeMediaTensaoSymbol extends ElectricShape {
  const RedeMediaTensaoSymbol({
    super.key,
    super.size = 180,
    super.color = const Color(0xFF2F3437),
    super.strokeWidth = 1,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size * 2.8, size * 0.28),
      painter: HorizontalLinePainter(
        color: color,
        strokeWidth: strokeWidth,
        isDashed: true,
      ),
    );
  }

  @override
  ElectricShape copyWith({double? size, Color? color, double? strokeWidth}) {
    return RedeMediaTensaoSymbol(
      size: size ?? this.size,
      color: color ?? this.color,
      strokeWidth: strokeWidth ?? this.strokeWidth,
    );
  }
}
