import 'package:electric_digital_sketch/ui/widgets/core/color_picker/gradient_picker/viewmodels/gradient_picker_controller.dart';
import 'package:electric_digital_sketch/ui/widgets/core/color_picker/gradient_picker/widgets/direction_buttons.dart';
import 'package:electric_digital_sketch/ui/widgets/core/color_picker/gradient_picker/widgets/gradient_color_menu.dart';
import 'package:electric_digital_sketch/ui/widgets/core/color_picker/gradient_picker/widgets/gradient_stop_range.dart';
import 'package:electric_digital_sketch/ui/widgets/core/color_picker/gradient_picker/widgets/palette/stop_palette.dart';
import 'package:electric_digital_sketch/ui/widgets/core/color_picker/models/color_picker_value.dart';
import 'package:flutter/material.dart';

class GradientPickerWidget extends StatefulWidget {
  const GradientPickerWidget({
    required this.initialValue,
    this.onChanged,
    super.key,
  });

  final GradientValue initialValue;
  final ValueChanged<GradientValue>? onChanged;

  @override
  State<GradientPickerWidget> createState() => _GradientPickerWidgetState();
}

class _GradientPickerWidgetState extends State<GradientPickerWidget> {

  late final GradientPickerController controller;

  @override
  void initState() {
    controller = GradientPickerController(
      direction: widget.initialValue.direction,
      initialStops: widget.initialValue.stops
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            GradientStopRange(
              stops: controller.sortedStops,
              selectedStop: controller.selectedStop,
              gradient: controller.gradient,
              onSelected: (stop) {
                controller.selectedStop = stop;
              },
              onDragged: controller.moveStop,
            ),
            StopPalette(stops: controller.stops),
            GradientColorMenu(controller: controller),
            DirectionButtonsWidget(
              initialValue: controller.direction,
              onChanged: (value) {
                controller.setDirection(value);
              },
            ),
          ],
        );
      },
    );
  }

  void notifyChanged() {
    final stops = controller.sortedStops;

    widget.onChanged?.call(
      GradientValue(
        colors: [for (final stop in stops) stop.color],
        stops: [for (final stop in stops) stop.position],
        begin: controller.direction.begin,
        end: controller.direction.end,
      ),
    );
  }
}
