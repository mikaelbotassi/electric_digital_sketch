import 'package:electric_digital_sketch/domain/enums/line_style.dart';
import 'package:electric_digital_sketch/ui/widgets/core/double_switch.dart';
import 'package:electric_digital_sketch/ui/viewmodels/electric_sketch_controller.dart';
import 'package:electric_digital_sketch/ui/widgets/core/toggle_button/toggle_button_group.dart';
import 'package:flutter/material.dart';
import 'package:mb_color_picker/mb_color_picker.dart';
import 'package:simple_painter/simple_painter.dart';

class LineOptions extends StatelessWidget {
  const LineOptions({required this.controller, super.key});
  final ElectricSketchController controller;
  @override
  Widget build(BuildContext context) {
    final painterController = controller.painterController;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.hasPendingLinePoint
                ? 'Toque no segundo ponto para desenhar a linha.'
                : 'Toque na tela para marcar o primeiro ponto.',
          ),
          const SizedBox(height: 16),
          DoubleSwitch(
            label: 'Tamanho',
            initialValue: painterController.value.brushSize,
            minValue: 1,
            onChanged: (value){
              painterController.changeBrushValues(
                size: value,
              );
            },
          ),
          Row(
            spacing: 16,
            children: [
              const Text('Cor'),
              MbColorPickerWidget(
                allowedTypes: const {ColorPickerType.solid},
                initialValue: SolidColorValue(painterController.value.brushColor),
                onChanged: (color){
                  if(color is SolidColorValue){
                    painterController.changeBrushValues(color: color.value);
                  }
                }
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Tipo de linha'),
          const SizedBox(height: 8),
          ToggleButtonGroup(
            initialValue: controller.lineStyle,
            options: [],
          ),
          ...LineStyle.values.map(
            (style) => RadioListTile<LineStyle>(
              contentPadding: EdgeInsets.zero,
              title: Text(style.label),
              value: style,
              groupValue: controller.lineStyle,
              onChanged: (value) {
                if (value != null) {
                  controller.setLineStyle(value);
                }
              },
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: controller.hasPendingLinePoint
                ? controller.clearPendingLinePoint
                : null,
            child: const Text('Limpar primeiro ponto'),
          ),
        ],
      ),
    );
  }
  
  List<dynamic> get options => LineStyle.values.map((e) => ToggleButtonOption(
    value: e,
    icon: e.icon
  )).toList(growable: false);
}
