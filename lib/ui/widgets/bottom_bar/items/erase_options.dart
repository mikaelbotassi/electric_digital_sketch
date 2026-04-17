import 'package:electric_digital_sketch/ui/widgets/core/double_switch.dart';
import 'package:flutter/material.dart';
import 'package:simple_painter/simple_painter.dart';

class EraseOptions extends StatelessWidget {
  const EraseOptions({required this.controller, super.key});
  final PainterController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: DoubleSwitch(
        label: 'Tamanho',
        initialValue: controller.value.brushSize,
        minValue: 1,
        onChanged: (value){
          controller.changeBrushValues(
            size: value,
          );
        },
      ),
    );
  }
}
