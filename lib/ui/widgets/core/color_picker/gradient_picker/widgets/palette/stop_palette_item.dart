import 'package:electric_digital_sketch/ui/widgets/core/color_picker/color_picker.dart';
import 'package:electric_digital_sketch/ui/widgets/core/color_picker/models/color_picker_type.dart';
import 'package:electric_digital_sketch/ui/widgets/core/color_picker/models/color_picker_value.dart';
import 'package:electric_digital_sketch/ui/widgets/core/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

class StopPaletteItem extends StatelessWidget {
  const StopPaletteItem({
    required this.color,
    required this.position,
    required this.onChanged,
    required this.onRemove,
    this.active = false,
    super.key,
  });

  final Color color;
  final double position;
  final ValueChanged<ColorPickerValue> onChanged;
  final VoidCallback onRemove;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: active ? colors.inverseSurface.withAlpha(50) :
          Colors.transparent,
        borderRadius: BorderRadius.circular(4)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ColorPickerWidget(
            allowedTypes: const {ColorPickerType.solid},
            initialValue: SolidColorValue(color),
            onChanged: onChanged,
          ),
          IconButtonWidget(
            icon: TablerIcons.minus,
            onPressed: onRemove,
          )
        ],
      ),
    );
  }
}
