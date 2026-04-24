import 'package:electric_digital_sketch/ui/widgets/core/color_picker/models/color_picker_type.dart';
import 'package:electric_digital_sketch/ui/widgets/core/toggle_button/toggle_button_group.dart';
import 'package:flutter/material.dart';

class ColorPickerDialogHeader extends StatelessWidget {
  const ColorPickerDialogHeader({
    required this.type,
    required this.onChanged,
    super.key
  });

  final ValueChanged<ColorPickerType> onChanged;
  final ColorPickerType type;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IntrinsicWidth(
          child: ToggleButtonGroup(
            initialValue: type,
            onChanged: onChanged,
            options: options
          ),
        ),
      ],
    );
  }

  List<ToggleButtonOption<ColorPickerType>> get options =>
    ColorPickerType.values.map(
    (type) => ToggleButtonOption(value: type, icon: type.icon)
    ).toList(growable: false);

}
