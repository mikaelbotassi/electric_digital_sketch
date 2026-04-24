import 'package:flutter/material.dart';

class GradientPickerValue {
  const GradientPickerValue({
    required this.colors,
    required this.stops,
    required this.begin,
    required this.end,
  });

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
}
