import 'package:electric_digital_sketch/domain/enums/sketch_mode.dart';
import 'package:electric_digital_sketch/ui/viewmodels/electric_sketch_controller.dart';
import 'package:flutter/material.dart';

class ToolbarItemWidget extends StatelessWidget {
  const ToolbarItemWidget({
    required this.mode,
    required this.controller,
    super.key
  });

  final SketchMode mode;
  final ElectricSketchController controller;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isActive = mode == controller.mode;
    return InkWell(
      onTap: () => controller.setMode(mode, context),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isActive ? colors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(
          mode.icon,
            color: isActive ? colors.onPrimary : colors.primary
        ),
      ),
    );
  }
}
