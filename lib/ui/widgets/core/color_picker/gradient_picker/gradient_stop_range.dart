import 'package:electric_digital_sketch/ui/widgets/core/color_picker/gradient_picker/gradient_stop_handle.dart';
import 'package:electric_digital_sketch/ui/widgets/core/color_picker/gradient_picker/models/gradient_stop.dart';
import 'package:flutter/material.dart';

class GradientStopRange extends StatelessWidget {
  const GradientStopRange({
    required this.stops,
    required this.selectedStop,
    required this.gradient,
    required this.onSelected,
    required this.onDragged,
    super.key,
  });

  final List<GradientStop> stops;
  final GradientStop selectedStop;
  final LinearGradient gradient;
  final ValueChanged<GradientStop> onSelected;
  final void Function(double delta) onDragged;

  static const width = 360.0;
  static const stopHeight = 24;
  static const rangeHeight = 24;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: width,
        height: 64,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 10,
              width: width,
              height: 16,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: colors.outlineVariant),
                  gradient: gradient,
                ),
              ),
            ),
            for (final stop in stops)
              Positioned(
                left: (stop.position * width - 14).clamp(0, width - 28),
                top: 5,
                child: GradientStopHandle(
                  color: stop.color,
                  selected: stop == selectedStop,
                  onTap: () => onSelected(stop),
                  onDragged: (details) {
                    onDragged(details.delta.dx / width);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

}
