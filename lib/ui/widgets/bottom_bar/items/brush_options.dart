import 'package:electric_digital_sketch/ui/widgets/core/color_picker/color_picker.dart';
import 'package:electric_digital_sketch/ui/widgets/core/color_picker/models/color_picker_type.dart';
import 'package:electric_digital_sketch/ui/widgets/core/color_picker/models/color_picker_value.dart';
import 'package:electric_digital_sketch/ui/widgets/core/double_switch.dart';
import 'package:flutter/material.dart';
import 'package:simple_painter/simple_painter.dart';

class BrushOptions extends StatelessWidget {
  const BrushOptions({required this.controller, super.key});
  final PainterController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DoubleSwitch(
            label: 'Tamanho',
            initialValue: controller.value.brushSize,
            minValue: 1,
            onChanged: (value){
              controller.changeBrushValues(
                size: value,
              );
            },
          ),
          Row(
            spacing: 16,
            children: [
              const Text('Cor'),
              ColorPickerWidget(
                allowedTypes: const {ColorPickerType.solid},
                initialValue: SolidColorValue(controller.value.brushColor),
                onChanged: (color){
                  if(color is SolidColorValue){
                    controller.changeBrushValues(color: color.value);
                  }
                }
              ),
            ],
          )
        ],
      ),
    );
  }
}
