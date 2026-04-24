import 'package:electric_digital_sketch/ui/widgets/core/color_picker/gradient_picker/models/direction_option.dart';
import 'package:electric_digital_sketch/ui/widgets/core/color_picker/gradient_picker/models/gradient_picker_value.dart';
import 'package:electric_digital_sketch/ui/widgets/core/color_picker/gradient_picker/models/gradient_stop.dart';
import 'package:electric_digital_sketch/ui/widgets/core/color_picker/gradient_picker/viewmodels/gradient_picker_controller.dart';
import 'package:electric_digital_sketch/ui/widgets/core/color_picker/gradient_picker/widgets/color_stop_preview.dart';
import 'package:electric_digital_sketch/ui/widgets/core/color_picker/gradient_picker/widgets/direction_buttons.dart';
import 'package:electric_digital_sketch/ui/widgets/core/color_picker/gradient_picker/widgets/gradient_stop_range.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class GradientPickerWidget extends StatefulWidget {
  const GradientPickerWidget({
    this.direction = GradientDirectionOption.back,
    this.stops = const [],
    this.onChanged,
    super.key,
  });

  final GradientDirectionOption direction;
  final List<GradientStop> stops;
  final ValueChanged<GradientPickerValue>? onChanged;

  @override
  State<GradientPickerWidget> createState() => _GradientPickerWidgetState();
}

class _GradientPickerWidgetState extends State<GradientPickerWidget> {
  final List<GradientStop> gradientStops = [];

  late Alignment begin;
  late Alignment end;

  late final GradientPickerController controller;

  @override
  void initState() {
    controller = GradientPickerController(
      direction: widget.direction,
      initialStops: widget.stops
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
            Row(
              children: [
                ColorStopPreview(
                  label: 'Cor ${controller.selectedStop.positionLabel}',
                  color: controller.selectedStop.color,
                ),
                const Spacer(),
                IconButton.filledTonal(
                  tooltip: 'Adicionar cor',
                  icon: const Icon(Icons.add),
                  onPressed: controller.createStop,
                ),
                const SizedBox(width: 8),
                IconButton.filledTonal(
                  tooltip: 'Remover cor',
                  icon: const Icon(Icons.delete_outline),
                  onPressed: gradientStops.length > 2 ?
                    controller.removeSelectedStop : null,
                ),
              ],
            ),
            ColorPicker(
              pickerColor: controller.selectedStop.color,
              onColorChanged: controller.changeSelectedColor,
              displayThumbColor: true,
              pickerAreaHeightPercent: 0.75,
            ),
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
      GradientPickerValue(
        colors: [for (final stop in stops) stop.color],
        stops: [for (final stop in stops) stop.position],
        begin: begin,
        end: end,
      ),
    );
  }
}
