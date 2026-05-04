import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/text_items/font_size_range.dart';
import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/text_items/text_align_input.dart';
import 'package:flutter/material.dart';
import 'package:mb_color_picker/mb_color_picker.dart';
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
          MbColorPickerWidget(
            maxStops: 2,
            initialValue: item.enableGradientColor ?
            GradientValue(
              stops: [
                GradientStop(color: item.gradientStartColor, position: 0),
                GradientStop(color: item.gradientEndColor, position: 1),
              ],
              begin: item.gradientBegin,
              end: item.gradientEnd
            ) : SolidColorValue(item.textStyle.color ?? Colors.white),
            onChanged: (value) {
              if(value is GradientValue){
                controller.changeTextValues(
                  item,
                  enableGradientColor: true,
                  gradientBegin: value.begin,
                  gradientEnd: value.end,
                  gradientStartColor: value.startColor,
                  gradientEndColor: value.endColor
                );
                return;
              }
              controller.changeTextValues(
                item,
                enableGradientColor: false,
                textStyle: item.textStyle.copyWith(
                  color: value.toSolidColor(),
                ),
              );
            },
          ),
          MbColorPickerWidget(
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
