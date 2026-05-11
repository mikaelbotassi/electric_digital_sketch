import 'package:electric_digital_sketch/domain/enums/line_style.dart';
import 'package:electric_digital_sketch/ui/viewmodels/electric_sketch_controller.dart';
import 'package:electric_digital_sketch/ui/widgets/core/toggle_button/toggle_button_group.dart';
import 'package:flutter/material.dart';

class RedeTypeSelectWidget extends StatelessWidget {
  const RedeTypeSelectWidget({required this.controller, super.key});

  final ElectricSketchController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      spacing: 8,
      children: [
        const Text('Tipo de rede'),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ToggleButtonGroup(
            onChanged: controller.setLineStyle,
            initialValue: controller.lineStyle,
            options: options,
          ),
        ),
      ],
    );
  }

  List<ToggleButtonOption<LineStyle>> get options => LineStyle.values.map((e) =>
      ToggleButtonOption(value: e, icon: e.icon, text: e.label))
      .toList(growable: false);

}
