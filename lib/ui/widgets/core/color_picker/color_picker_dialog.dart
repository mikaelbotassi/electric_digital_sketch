import 'package:electric_digital_sketch/ui/widgets/core/color_picker/gradient_picker/gradient_picker_widget.dart';
import 'package:electric_digital_sketch/ui/widgets/core/color_picker/gradient_picker/widgets/color_picker_dialog_header.dart';
import 'package:electric_digital_sketch/ui/widgets/core/color_picker/models/color_picker_type.dart';
import 'package:electric_digital_sketch/ui/widgets/core/color_picker/models/color_picker_value.dart';
import 'package:electric_digital_sketch/ui/widgets/core/color_picker/models/solid_color_value.dart';
import 'package:electric_digital_sketch/ui/widgets/core/primary_button.dart';
import 'package:electric_digital_sketch/ui/widgets/core/text_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

class ColorPickerDialog extends StatefulWidget {

  const ColorPickerDialog({required this.initialColor, super.key});

  final Color initialColor;

  @override
  State<ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {

  late ColorPickerValue<dynamic> selectedColor;
  ColorPickerType type = ColorPickerType.solid;

  @override
  void initState() {
    selectedColor = SolidColorValue(widget.initialColor);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final (colors, textTheme) = (theme.colorScheme, theme.textTheme);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(8),
        side: BorderSide(
          color: colors.inverseSurface.withAlpha(100),
          width: 2
        )
      ),
      title: ColorPickerDialogHeader(
        onChanged: (newType){
          setState(() {
            type = newType;
          });
        },
        type: type,
      ),
      content: SizedBox(
        width: 360,
        child: SingleChildScrollView(
          child: type == ColorPickerType.solid ? ColorPicker(
            pickerColor: selectedColor.toSolidColor(),
            onColorChanged: (color) {
              selectedColor = SolidColorValue(color);
            },
            displayThumbColor: true,
            pickerAreaHeightPercent: 0.8,
          ) : const GradientPickerWidget(),
        ),
      ),
      actions: [
        TextButtonWidget(
          onPressed: () => Navigator.pop(context, widget.initialColor),
          icon: TablerIcons.x,
          text: 'Cancelar',
        ),
        PrimaryButton(
          onPressed: () {
            Navigator.pop(context, selectedColor);
          },
          icon: TablerIcons.check,
          text: 'Aplicar',
        )
      ],
    );
  }
}
