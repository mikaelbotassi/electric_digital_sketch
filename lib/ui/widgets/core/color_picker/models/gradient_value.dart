import 'package:electric_digital_sketch/ui/widgets/core/color_picker/models/color_picker_value.dart';
import 'package:flutter/material.dart';

class GradientValue extends ColorPickerValue<Gradient> {
  GradientValue({
    required this.colors,
    required this.stops,
    required this.begin,
    required this.end,
  }) : super();

  final List<Color> colors;
  final List<double> stops;
  final Alignment begin;
  final Alignment end;

  Color get startColor => colors.first;

  Color get endColor => colors.last;

  LinearGradient get gradient {
    return LinearGradient(
      colors: colors,
      stops: stops,
      begin: begin,
      end: end,
    );
  }

  @override
  Gradient get value => gradient;

}
