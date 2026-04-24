import 'package:electric_digital_sketch/ui/widgets/core/color_picker/gradient_picker/widgets/palette/stop_palette_item.dart';
import 'package:electric_digital_sketch/ui/widgets/core/color_picker/models/gradient_stop.dart';
import 'package:flutter/material.dart';

class StopPalette extends StatelessWidget {
  const StopPalette({required this.stops, super.key});

  final List<GradientStop> stops;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: stopWidgets,
    );
  }

  List<Widget> get stopWidgets => stops.map((stop) => StopPaletteItem(
    color: stop.color,
    position: stop.position
  )).toList(growable: false);

}
