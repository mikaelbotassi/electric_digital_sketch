import 'package:electric_digital_sketch/ui/widgets/core/double_switch.dart';
import 'package:flutter/material.dart';
import 'package:simple_painter/simple_painter.dart';

class FontSizeRange extends StatelessWidget {

  const FontSizeRange({required this.item, required this.controller, super.key});

  final PainterController controller;
  final TextItem item;

  @override
  Widget build(BuildContext context) {
    return DoubleSwitch(
      label: 'Tamanho da Fonte',
      initialValue: item.textStyle.fontSize!,
      minValue: 1,
      onChanged: (value){
        controller.changeTextValues(
          item, textStyle: item.textStyle.copyWith(fontSize: value)
        );
      },
    );
  }
}
