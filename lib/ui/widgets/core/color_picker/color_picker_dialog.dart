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

  @override
  void initState() {
    selectedColor = widget.initialColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Escolha uma cor'),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: widget.initialColor,
          onColorChanged: (color) {
            selectedColor = color;
          },
          displayThumbColor: true,
          pickerAreaHeightPercent: 0.8,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, widget.initialColor),
          child: const Text('Cancelar'),
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
