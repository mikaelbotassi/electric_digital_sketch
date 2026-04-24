import 'package:electric_digital_sketch/ui/widgets/core/color_picker/gradient_picker/viewmodels/gradient_picker_controller.dart';
import 'package:electric_digital_sketch/ui/widgets/core/color_picker/gradient_picker/widgets/color_stop_preview.dart';
import 'package:flutter/material.dart';

class GradientColorMenu extends StatelessWidget {
  const GradientColorMenu({required this.controller, super.key});

  final GradientPickerController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ColorStopPreview(
            label: 'Cor ${controller.selectedStop.positionLabel}',
            color: controller.selectedStop.color,
          ),
        ),
        Row(
          spacing: 8,
          children: [
            IconButton.filledTonal(
              tooltip: 'Adicionar cor',
              icon: const Icon(Icons.add),
              onPressed: controller.createStop,
            ),
            IconButton.filledTonal(
              tooltip: 'Remover cor',
              icon: const Icon(Icons.delete_outline),
              onPressed: controller.stops.length > 2 ?
              controller.removeSelectedStop : null,
            ),
          ],
        )
      ],
    );
  }
}
