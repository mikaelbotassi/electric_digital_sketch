import 'package:electric_digital_sketch/ui/widgets/core/text_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerDialog extends StatefulWidget {

  const ColorPickerDialog({required this.initialColor, super.key});

  final Color initialColor;

  @override
  State<ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {

  late Color selectedColor;
  final controller = TextEditingController();

  @override
  void initState() {
    selectedColor = widget.initialColor;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final (colors, textTheme) = (theme.colorScheme, theme.textTheme);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(8),
        side: const BorderSide(
          color: Colors.white38
        )
      ),
      title: Text(
        'Escolha uma cor',
        style: textTheme.titleLarge
      ),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: widget.initialColor,
          onColorChanged: (color) {
            selectedColor = color;
          },
          hexInputController: controller,
          displayThumbColor: true,
          pickerAreaHeightPercent: 0.8,
        ),
      ),
      actions: [
        TextButtonWidget(
          onPressed: () => Navigator.pop(context, widget.initialColor),
          text: 'Cancelar',
        ),
        FilledButton(
          onPressed: () {
            Navigator.pop(context, selectedColor);
          },
          child: const Text('Aplicar'),
        ),
      ],
    );
  }
}
