import 'package:electric_digital_sketch/ui/widgets/core/color_picker/color_picker_dialog.dart';
import 'package:electric_digital_sketch/ui/widgets/core/color_picker/gradient_picker/widgets/text_fields/color_opacity_text_field.dart';
import 'package:electric_digital_sketch/ui/widgets/core/color_picker/gradient_picker/widgets/text_fields/hexadecimal_color_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerWidget extends StatefulWidget {
  const ColorPickerWidget({
    required this.onChanged,
    this.initialColor = Colors.blue,
    this.label = 'Cor',
    this.textStyle,
    super.key
  });

  final String label;
  final Color initialColor;
  final ValueChanged<Color> onChanged;
  final TextStyle? textStyle;

  @override
  State<ColorPickerWidget> createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  late Color selectedColor;

  late final TextEditingController hexadecimalController;
  late final TextEditingController opacityController;

  @override
  void initState() {
    selectedColor = widget.initialColor;
    hexadecimalController = TextEditingController(
      text: hexadecimalColor.replaceFirst('#', ''),
    );
    opacityController = TextEditingController(
      text: opacityPercentage.toString(),
    );
    super.initState();
  }

  @override
  void dispose() {
    hexadecimalController.dispose();
    opacityController.dispose();
    super.dispose();
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
        _syncControllers();
      });
      widget.onChanged(newColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final (textStyle, colors) = (widget.textStyle ?? theme.textTheme.bodyMedium,
      theme.colorScheme);
    final colorPickerHeight = (textStyle?.fontSize ?? 24) * 2;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: colors.onSurface.withAlpha(100))
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 4,
          children: [
            Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                spacing: 8,
                children: [
                  GestureDetector(
                    onTap: openColorPicker,
                    child: Container(
                      width: colorPickerHeight,
                      height: colorPickerHeight,
                      decoration: BoxDecoration(
                        color: selectedColor,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: colors.onSurface
                          .withAlpha(100))
                      ),
                    ),
                  ),
                  HexadecimalColorTextField(
                    hexadecimalController: hexadecimalController,
                    textStyle: textStyle,
                    onHexadecimalSubmitted: _handleHexadecimalSubmitted,
                  )
                ],
              ),
            ),
            VerticalDivider(
              color: colors.onSurface.withAlpha(100),
              width: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: ColorOpacityTextField(
                textStyle: textStyle,
                controller: opacityController,
                onOpacitySubmitted: _handleOpacitySubmitted,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _handleHexadecimalSubmitted(String value) {
    final normalizedValue = value.trim().replaceAll('#', '');

    if (normalizedValue.isEmpty) {
      _syncControllers();
      return;
    }

    final hexValue = normalizedValue.length >= 6
        ? normalizedValue.substring(0, 6)
        : normalizedValue.padRight(6,
          normalizedValue[normalizedValue.length - 1]);

    final parsedColor = Color(
      int.parse(
        '${alphaChannel.toRadixString(16).padLeft(2, '0')}$hexValue',
        radix: 16,
      ),
    );

    setState(() {
      selectedColor = parsedColor;
      _syncControllers();
    });

    widget.onChanged(parsedColor);
  }

  void _handleOpacitySubmitted(int value) {

    final clampedValue = value.clamp(0, 100);
    final alpha = (clampedValue * 255 / 100).round();
    final updatedColor = selectedColor.withAlpha(alpha);

    setState(() {
      selectedColor = updatedColor;
      _syncControllers();
    });

    widget.onChanged(updatedColor);
  }

  void _syncControllers() {
    hexadecimalController.text = hexadecimalColor.replaceFirst('#', '');
    opacityController.text = opacityPercentage.toString();
  }

  int get alphaChannel => (selectedColor.a * 255).round().clamp(0, 255);

  int get opacityPercentage => (alphaChannel / 255 * 100).round();

  String get hexadecimalColor{
    if (alphaChannel == 0) {
      return 'Transparent';
    }
    return selectedColor.toHexString().replaceRange(0, 2, '#');
  }

}
