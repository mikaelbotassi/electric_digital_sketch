import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/text_items/font_size_range.dart';
import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/text_items/text_align_input.dart';
import 'package:electric_digital_sketch/ui/widgets/core/color_picker/color_picker.dart';
import 'package:electric_digital_sketch/ui/widgets/core/color_picker/models/color_picker_type.dart';
import 'package:electric_digital_sketch/ui/widgets/core/color_picker/models/color_picker_value.dart';
import 'package:flutter/material.dart';
import 'package:electric_digital_sketch/widgets/options/options.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:simple_painter/simple_painter.dart';

class TextOptions extends StatelessWidget {
  const TextOptions({required this.controller, required this.item, super.key});

  final PainterController controller;
  final TextItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 16,
        children: [
          FontSizeRange(controller: controller, item: item),
          TextAlignInput(controller: controller, item: item),
          ColorPickerWidget(
            allowedTypes: const {ColorPickerType.solid},
            initialValue: SolidColorValue(item.textStyle.color ?? Colors.white),
            onChanged: (value) {
              controller.changeTextValues(
                item,
                textStyle: item.textStyle.copyWith(
                  color: value.toSolidColor(),
                ),
              );
            },
          ),
          ColorPickerWidget(
            allowedTypes: const {ColorPickerType.solid},
            initialValue: SolidColorValue(
              item.textStyle.backgroundColor ?? Colors.transparent,
            ),
            onChanged: (value) {
              controller.changeTextValues(
                item,
                textStyle: item.textStyle.copyWith(
                  backgroundColor: value.toSolidColor(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
