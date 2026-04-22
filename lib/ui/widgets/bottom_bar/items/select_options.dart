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
        return const SizedBox.shrink();
      },
    );
  }

}
