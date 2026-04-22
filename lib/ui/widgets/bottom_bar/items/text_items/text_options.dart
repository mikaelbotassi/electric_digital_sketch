import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/text_items/font_size_range.dart';
import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/text_items/text_align_input.dart';
import 'package:electric_digital_sketch/ui/widgets/core/color_picker/color_picker.dart';
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
            initialColor: item.textStyle.color!,
            onChanged: (color){
              controller.changeTextValues(
                item,
                textStyle: item.textStyle.copyWith(color: color)
              );
            }
          ),
          ColorPickerWidget(
            label: 'Cor de fundo',
            initialColor: item.textStyle.backgroundColor!,
            onChanged: (color){
              controller.changeTextValues(
                item,
                textStyle: item.textStyle.copyWith(backgroundColor: color)
              );
            }
          ),
          gradient
        ],
      ),
    );
  }

  Widget get gradient {
    Widget arrow(IconData icon, Alignment begin, Alignment end) {
      return IconButton(
        onPressed: () {
          controller.changeTextValues(
            item,
            gradientBegin: begin,
            gradientEnd: end,
          );
        },
        icon: Icon(
          icon,
          color: Colors.white,
        ),
      );
    }

    return Column(
      children: [
        Row(
          children: [
            title('Gradient'),
            const Spacer(),
            Switch(
              value: item.enableGradientColor,
              onChanged: (value) {
                controller.changeTextValues(
                  item,
                  enableGradientColor: value,
                );
              },
            ),
          ],
        ),
        Column(
          children: [
            colorSwitch(
              'Gradient Start Color',
              item.gradientStartColor,
              (value) {
                controller.changeTextValues(
                  item,
                  gradientStartColor: Color(value.toInt())
                      .withValues(alpha: item.gradientStartColor.a),
                );
              },
              opacityCondition: !item.enableGradientColor,
            ),
            colorSwitch(
              'Gradient End Color',
              item.gradientEndColor,
              (value) {
                controller.changeTextValues(
                  item,
                  gradientEndColor: Color(value.toInt())
                      .withValues(alpha: item.gradientEndColor.a),
                );
              },
              opacityCondition: !item.enableGradientColor,
            ),
            SizedBox(
              height: 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  arrow(
                    PhosphorIconsRegular.arrowLeft,
                    Alignment.centerRight,
                    Alignment.centerLeft,
                  ),
                  arrow(
                    PhosphorIconsRegular.arrowRight,
                    Alignment.centerLeft,
                    Alignment.centerRight,
                  ),
                  arrow(
                    PhosphorIconsRegular.arrowUp,
                    Alignment.bottomCenter,
                    Alignment.topCenter,
                  ),
                  arrow(
                    PhosphorIconsRegular.arrowDown,
                    Alignment.topCenter,
                    Alignment.bottomCenter,
                  ),
                  arrow(
                    PhosphorIconsRegular.arrowUpRight,
                    Alignment.bottomLeft,
                    Alignment.topRight,
                  ),
                  arrow(
                    PhosphorIconsRegular.arrowUpLeft,
                    Alignment.bottomRight,
                    Alignment.topLeft,
                  ),
                  arrow(
                    PhosphorIconsRegular.arrowDownRight,
                    Alignment.topLeft,
                    Alignment.bottomRight,
                  ),
                  arrow(
                    PhosphorIconsRegular.arrowDownLeft,
                    Alignment.topRight,
                    Alignment.bottomLeft,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
