import 'package:electric_digital_sketch/ui/widgets/core/color_picker/models/direction_option.dart';
import 'package:electric_digital_sketch/ui/widgets/core/color_picker/models/gradient_stop.dart';
import 'package:flutter/material.dart';

sealed class ColorPickerValue<T extends Object> {
  const ColorPickerValue();

  T get value;
  double get opacity;

  ColorPickerValue<T> copyWithOpacity(double opacity);

  Gradient toGradient() {
    return switch (this) {
      GradientValue(:final gradient) => gradient,
      SolidColorValue(:final value) => LinearGradient(
        colors: [
          value,
          value,
        ],
      ),
    };
  }

  Color toSolidColor(){
    return switch (this) {
      GradientValue(:final gradient) => gradient.colors.first,
      SolidColorValue(:final value) => value,
    };
  }

}

class GradientValue extends ColorPickerValue<Gradient> {
  const GradientValue({
    required this.colors,
    required this.stops,
    required this.begin,
    required this.end,
    this.alpha = 1,
  }) : assert(colors.length == stops.length, 'The number of colors should '
    'correspond to the number of stops.');

  final List<Color> colors;
  final List<double> stops;
  final Alignment begin;
  final Alignment end;
  final double alpha;

  Color get startColor => colors.first;

  Color get endColor => colors.last;

  LinearGradient get gradient {
    return LinearGradient(
      colors: [
        for (final color in colors)
          color.withValues(alpha: color.a * alpha),
      ],
      stops: stops,
      begin: begin,
      end: end,
    );
  }

  @override
  Gradient get value => gradient;

  GradientDirectionOption get direction => GradientDirectionOption
    .fromBeginAndEnd(begin, end);

  GradientStop get gradientStops =>

  @override
  double get opacity => alpha;

  GradientValue copyWith({
    List<Color>? colors,
    List<double>? stops,
    Alignment? begin,
    Alignment? end,
    double? alpha,
  }) {
    return GradientValue(
      colors: colors ?? this.colors,
      stops: stops ?? this.stops,
      begin: begin ?? this.begin,
      end: end ?? this.end,
      alpha: (alpha ?? this.alpha).clamp(0, 1),
    );
  }

  @override
  GradientValue copyWithOpacity(double opacity) {
    return copyWith(alpha: opacity);
  }

}

class SolidColorValue extends ColorPickerValue<Color>{

  const SolidColorValue(this.value);

  @override
  final Color value;

  @override
  double get opacity => value.a;

  @override
  SolidColorValue copyWithOpacity(double opacity) {
    return SolidColorValue(
      value.withValues(alpha: opacity.clamp(0, 1)),
    );
  }

}
