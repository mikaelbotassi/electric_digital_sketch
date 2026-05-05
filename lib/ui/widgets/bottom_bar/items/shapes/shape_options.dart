import 'package:electric_digital_sketch/ui/widgets/core/double_switch.dart';
import 'package:flutter/material.dart';
import 'package:mb_color_picker/mb_color_picker.dart';
import 'package:simple_painter/simple_painter.dart';

class ShapeOptions extends StatelessWidget {

  const ShapeOptions({required this.controller, required this.item, super.key});
  final PainterController controller;
  final ShapeItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 8,
        children: [
          Row(
            spacing: 16,
            children: [
              const Text('Cor da linha'),
              MbColorPickerWidget(
                allowedTypes: const {ColorPickerType.solid},
                onChanged: (newValue){
                  controller.changeShapeValues(
                    item,
                    lineColor: newValue.toSolidColor(),
                  );
                },
                initialValue: SolidColorValue(item.lineColor),
              ),
            ],
          ),
          DoubleSwitch(
            label: 'Grossura',
            initialValue: item.thickness,
            onChanged: (newValue){
              controller.changeShapeValues(
                item,
                thickness: newValue,
              );
            },
          ),
          if(isShapeNotLineOrArrow)
            Row(
              spacing: 16,
              children: [
                const Text('Cor do fundo'),
                MbColorPickerWidget(
                  allowedTypes: const {ColorPickerType.solid},
                  onChanged: (newValue){
                    controller.changeShapeValues(
                      item,
                      backgroundColor: newValue.toSolidColor(),
                    );
                  },
                  initialValue: SolidColorValue(item.backgroundColor),
                ),
              ],
            ),
        ],
      ),
    );
  }

  bool get isShapeNotLineOrArrow =>
      item.shapeType != ShapeType.line &&
          item.shapeType != ShapeType.arrow &&
          item.shapeType != ShapeType.doubleArrow;

}
