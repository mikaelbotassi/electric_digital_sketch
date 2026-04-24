import 'package:electric_digital_sketch/ui/widgets/core/color_picker/color_picker.dart';
import 'package:flutter/material.dart';

class StopPaletteItem extends StatelessWidget {
  const StopPaletteItem({
    required this.color,
    required this.position,
    super.key
  });

  final Color color;
  final double position;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ColorPickerWidget(
        onChanged: (value){},
      ),
    );
  }
}
