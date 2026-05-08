import 'package:electric_digital_sketch/ui/widgets/core/double_switch.dart';
import 'package:electric_shapes/electric_shapes.dart';
import 'package:flutter/material.dart';
import 'package:mb_color_picker/mb_color_picker.dart';
import 'package:simple_painter/simple_painter.dart';

class CustomShapeOptions extends StatelessWidget {

  const CustomShapeOptions({
    required this.controller,
    required this.item,
    super.key
  });

  final PainterController controller;
  final CustomWidgetItem item;

  @override
  Widget build(BuildContext context) {
    if(item.widget is! ElectricShape){
      return const SizedBox.shrink();
    }
    final widget = item.widget as ElectricShape;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 8,
        children: [
          Row(
            spacing: 16,
            children: [
              const Text('Cor da Borda'),
              MbColorPickerWidget(
                allowedTypes: const {ColorPickerType.solid},
                onChanged: (newValue){
                  controller.changeCustomWidgetValues(
                    item,
                    widget: widget.copyWith(color: newValue.toSolidColor())
                  );
                },
                initialValue: SolidColorValue(widget.color),
              ),
            ],
          ),
          DoubleSwitch(
            label: 'Grossura da Borda',
            initialValue: widget.strokeWidth,
            onChanged: (newValue){
              controller.changeCustomWidgetValues(
                item,
                widget: widget.copyWith(strokeWidth: newValue)
              );
            },
          ),
        ],
      ),
    );
  }

}
