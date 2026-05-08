import 'package:electric_digital_sketch/domain/enums/line_style.dart';
import 'package:electric_digital_sketch/ui/viewmodels/electric_sketch_controller.dart';
import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/redes/rede_type_select_widget.dart';
import 'package:electric_digital_sketch/ui/widgets/core/alert.dart';
import 'package:electric_digital_sketch/ui/widgets/core/double_switch.dart';
import 'package:electric_digital_sketch/ui/widgets/core/primary_button.dart';
import 'package:electric_digital_sketch/ui/widgets/core/toggle_button/toggle_button_group.dart';
import 'package:flutter/material.dart';
import 'package:mb_color_picker/mb_color_picker.dart';
import 'package:simple_painter/simple_painter.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

class RedeOptions extends StatelessWidget {
  const RedeOptions({required this.controller, super.key});
  final ElectricSketchController controller;
  @override
  Widget build(BuildContext context) {
    final painterController = controller.painterController;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Alert(
            icon: TablerIcons.alertTriangle,
            color: Colors.blue,
            text: controller.hasPendingLinePoint
              ? 'Toque no segundo ponto para desenhar a linha.'
              : 'Toque na tela para marcar o primeiro ponto.',
          ),
          PrimaryButton(
            onPressed: controller.hasPendingLinePoint
                ? controller.clearPendingLinePoint
                : null,
            enabled: controller.hasPendingLinePoint,
            text: 'Limpar primeiro ponto',
          ),
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
                initialValue: SolidColorValue(
                  painterController.value.brushColor),
                onChanged: (color){
                  if(color is SolidColorValue){
                    painterController.changeBrushValues(color: color.value);
                  }
                }
              ),
            ],
          ),
          RedeTypeSelectWidget(controller: controller),
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
  
  List<ToggleButtonOption<LineStyle>> get options => LineStyle.values.map((e) =>
    ToggleButtonOption(value: e, icon: e.icon, text: e.label))
    .toList(growable: false);
}
