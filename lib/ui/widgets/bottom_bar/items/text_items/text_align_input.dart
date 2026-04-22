import 'package:electric_digital_sketch/ui/widgets/core/toggle_button/toggle_button_group.dart';
import 'package:flutter/material.dart';
import 'package:simple_painter/simple_painter.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

enum TextAlignInputOption{
  alignLeft(
    alignment: TextAlign.left,
    icon: TablerIcons.alignLeft,
  ),
  alignCenter(
      alignment: TextAlign.center,
    icon: TablerIcons.alignCenter,
  ),
  alignRight(
    alignment: TextAlign.right,
    icon: TablerIcons.alignRight,
  ),
  alignJustified(
    alignment: TextAlign.justify,
    icon: TablerIcons.alignJustified,
  );

  const TextAlignInputOption({
    required this.alignment,
    required this.icon,
  });

  final IconData icon;
  final TextAlign alignment;

  static TextAlignInputOption? fromTextAlign(TextAlign textAlign){
    return switch(textAlign){
      TextAlign.right => TextAlignInputOption.alignRight,
      TextAlign.left => TextAlignInputOption.alignLeft,
      TextAlign.center => TextAlignInputOption.alignCenter,
      TextAlign.justify => TextAlignInputOption.alignJustified,
      _ => null
    };
  }



}

class TextAlignInput extends StatelessWidget {

  const TextAlignInput({
    required this.item,
    required this.controller,
    super.key
  });

  final PainterController controller;
  final TextItem item;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      spacing: 16,
      children: [
        Text(
          'Alinhamento',
          style: textTheme.bodyMedium
        ),
        ToggleButtonGroup(
          initialValue: TextAlignInputOption.fromTextAlign(item.textAlign),
          options: options,
          onChanged: (newValue){
            controller.changeTextValues(item, textAlign: newValue.alignment);
          },
        )
      ],
    );
  }

  List<ToogleButtonOption<TextAlignInputOption>> get options =>
    TextAlignInputOption.values.map((o) => ToogleButtonOption(
      value: o,
      icon: o.icon,
    )).toList();

}
