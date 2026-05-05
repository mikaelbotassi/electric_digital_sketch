import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/shapes/custom_shape_options.dart';
import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/shapes/shape_options.dart';
import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/text_items/text_options.dart';
import 'package:flutter/material.dart';
import 'package:simple_painter/simple_painter.dart';

class SelectOptions extends StatelessWidget {
  const SelectOptions({required this.controller, super.key});
  final PainterController controller;


  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, value, child) {
        if (value.selectedItem is TextItem) {
          return TextOptions(
            controller: controller,
            item: value.selectedItem! as TextItem,
          );
        }
        if(value.selectedItem is ShapeItem){
          return ShapeOptions(
            controller: controller,
            item: value.selectedItem! as ShapeItem
          );
        }
        if(value.selectedItem is CustomWidgetItem){
          return CustomShapeOptions(
            controller: controller,
            item: value.selectedItem! as CustomWidgetItem,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

}
