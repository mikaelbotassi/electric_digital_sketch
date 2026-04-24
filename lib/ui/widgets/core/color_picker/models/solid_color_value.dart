import 'package:electric_digital_sketch/ui/widgets/core/color_picker/models/color_picker_value.dart';
import 'package:flutter/material.dart';

class SolidColorValue extends ColorPickerValue<Color>{

  SolidColorValue(this.value);

  @override
  final Color value;

}
