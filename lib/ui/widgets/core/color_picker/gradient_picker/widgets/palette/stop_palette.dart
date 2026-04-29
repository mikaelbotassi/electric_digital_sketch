import 'package:electric_digital_sketch/ui/widgets/core/color_picker/gradient_picker/viewmodels/gradient_picker_controller.dart';
import 'package:electric_digital_sketch/ui/widgets/core/color_picker/gradient_picker/widgets/gradient_color_menu.dart';
import 'package:electric_digital_sketch/ui/widgets/core/color_picker/gradient_picker/widgets/palette/stop_palette_item.dart';
import 'package:electric_digital_sketch/ui/widgets/core/color_picker/models/color_picker_value.dart';
import 'package:flutter/material.dart';

class StopPalette extends StatelessWidget {
  const StopPalette({
    required this.controller,
    super.key
  });

  final GradientPickerController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        GradientColorMenu(controller: controller),
        ...stopWidgets
      ],
    );
  }

  List<Widget> get stopWidgets => controller.sortedStops
    .map((stop) => StopPaletteItem(
      color: stop.color,
      position: stop.position,
      onRemove: () => controller.removeStop(stop),
      onChanged: (value){
        if(value is SolidColorValue){
          stop.color = value.value;
        }
      })).toList(growable: false);

}
