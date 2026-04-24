import 'package:electric_digital_sketch/ui/widgets/core/color_picker/models/gradient_value.dart';
import 'package:electric_digital_sketch/ui/widgets/core/color_picker/models/solid_color_value.dart';
import 'package:flutter/material.dart';

abstract class ColorPickerValue<T> {
  T get value;

  Gradient toGradient() {
    return switch (this) {
      GradientValue(:final gradient) => gradient,
      SolidColorValue(:final value) => LinearGradient(
        colors: [
          value,
          Colors.white,
        ],
      ),
      _ => throw Exception('Undefined Type'),
    };
  }

  Color toSolidColor(){
    return switch (this) {
      GradientValue(:final gradient) => gradient.colors.first,
      SolidColorValue(:final value) => value,
      _ => throw Exception('Undefined Type'),
    };
  }

}
