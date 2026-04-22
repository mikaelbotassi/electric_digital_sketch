import 'package:electric_digital_sketch/ui/widgets/core/color_picker/color_picker_dialog.dart';
import 'package:flutter/material.dart';

class ColorPickerWidget extends StatefulWidget {
  const ColorPickerWidget({
    required this.onChanged,
    this.initialColor = Colors.blue,
    this.label = 'Cor',
    super.key
  });

  final String label;
  final Color initialColor;
  final ValueChanged<Color> onChanged;

  @override
  State<ColorPickerWidget> createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  late Color selectedColor;

  @override
  void initState() {
    selectedColor = widget.initialColor;
    super.initState();
  }

  Future<void> openColorPicker() async {
    final newColor = await showDialog<Color>(
      context: context,
      builder: (context) {
        return ColorPickerDialog(
          initialColor: selectedColor
        );
      },
    );
    if (newColor != null) {
      setState(() {
        selectedColor = newColor;
        widget.onChanged(newColor);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final (textTheme, colors) = (theme.textTheme, theme.colorScheme);
    return Row(
      spacing: 12,
      children: [
        Text(
          widget.label,
          style: textTheme.bodyMedium,
        ),
        GestureDetector(
          onTap: openColorPicker,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: selectedColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: colors.onSurfaceVariant.withAlpha(100)),
            ),
          ),
        ),
        Text(
          '#${selectedColor.toARGB32().toRadixString(16)
            .padLeft(8, '0').toUpperCase()}',
          style: textTheme.bodyMedium?.apply(
            color: colors.onSurface.withAlpha(100)
          ),
        ),
      ],
    );
  }
}
