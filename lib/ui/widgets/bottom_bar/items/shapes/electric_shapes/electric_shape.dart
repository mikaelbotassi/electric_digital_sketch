import 'package:flutter/material.dart';

abstract class ElectricShape extends StatelessWidget {

  const ElectricShape({
    required this.size,
    required this.color,
    required this.strokeWidth,
    super.key
  });

  final double size;
  final Color color;
  final double strokeWidth;

  ElectricShape copyWith({double? size, Color? color, double? strokeWidth});

}
