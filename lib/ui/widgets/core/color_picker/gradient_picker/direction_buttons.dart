import 'package:electric_digital_sketch/ui/widgets/core/color_picker/gradient_picker/models/direction_option.dart';
import 'package:electric_digital_sketch/ui/widgets/core/toggle_button/toggle_button_group.dart';
import 'package:flutter/material.dart';

// @immutable
// class DirectionButtonsResult {
//   const DirectionButtonsResult(this.begin, this.end);
//
//   final Alignment begin;
//   final Alignment end;
//
//   @override
//   bool operator ==(Object other) {
//     return other is DirectionButtonsResult &&
//         other.begin == begin &&
//         other.end == end;
//   }
//
//   @override
//   int get hashCode => Object.hash(begin, end);
//
//   @override
//   String toString() {
//     return 'DirectionButtonsResult{begin: $begin, end: $end}';
//   }
// }

class DirectionButtonsWidget extends StatelessWidget {
  const DirectionButtonsWidget({
    required this.initialValue,
    required this.onChanged,
    super.key
  });

  final ValueChanged<GradientDirectionOption> onChanged;
  final GradientDirectionOption initialValue;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          'Direção',
          style: textTheme.labelLarge,
        ),
        ToggleButtonGroup(
          onChanged: onChanged,
          options: options,
          initialValue: initialValue,
        ),
      ],
    );
  }

  List<ToggleButtonOption<GradientDirectionOption>> get options =>
    GradientDirectionOption.values.map((o) => ToggleButtonOption(
    value: o,
    icon: o.icon,
  )).toList();
}
