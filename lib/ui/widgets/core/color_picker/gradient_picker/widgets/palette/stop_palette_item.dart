import 'package:electric_digital_sketch/ui/widgets/core/color_picker/color_picker.dart';
import 'package:electric_digital_sketch/ui/widgets/core/color_picker/models/color_picker_type.dart';
import 'package:electric_digital_sketch/ui/widgets/core/color_picker/models/color_picker_value.dart';
import 'package:flutter/material.dart';

class StopPaletteItem extends StatelessWidget {
  const StopPaletteItem({
    required this.color,
    required this.position,
    required this.onChanged,
    super.key
  });

  final Color color;
  final double position;
  final ValueChanged<ColorPickerValue> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ColorPickerWidget(
        allowedTypes: const {ColorPickerType.solid},
        initialValue: SolidColorValue(color),
        onChanged: onChanged,
      ),
    );
  }
}
