import 'package:electric_digital_sketch/ui/viewmodels/electric_sketch_controller.dart';
import 'package:electric_digital_sketch/ui/widgets/core/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

class UndoRedoButtonGroupWidget extends StatelessWidget {
  const UndoRedoButtonGroupWidget({required this.controller, super.key});

  final ElectricSketchController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButtonWidget(
          icon: TablerIcons.arrowBackUp,
          enabled: controller.canUndo,
          onPressed: controller.undo,
        ),
        IconButtonWidget(
          icon: TablerIcons.arrowForwardUp,
          enabled: controller.canRedo,
          onPressed: controller.redo,
        )
      ],
    );
  }
}
