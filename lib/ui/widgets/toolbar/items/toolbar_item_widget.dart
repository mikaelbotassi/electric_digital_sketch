import 'dart:async';

import 'package:electric_digital_sketch/domain/enums/sketch_mode.dart';
import 'package:electric_digital_sketch/ui/viewmodels/electric_sketch_controller.dart';
import 'package:flutter/material.dart';
import 'package:simple_painter/simple_painter.dart';

abstract class ToolbarItemWidget extends StatelessWidget {

  const ToolbarItemWidget({
    required this.controller,
    super.key
  });

  SketchMode get mode;
  PainterController get painterController => controller.painterController;
  final ElectricSketchController controller;

  bool get isActive => mode == controller.mode;
  FutureOr<void> onPressed(BuildContext context);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isActive = mode == controller.mode;
    return InkWell(
      onTap: () => onPressed(context),
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
