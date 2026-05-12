import 'package:electric_digital_sketch/domain/enums/sketch_mode.dart';
import 'package:electric_digital_sketch/ui/widgets/toolbar/items/toolbar_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:simple_painter/simple_painter.dart';

/// Toolbar entry that activates brush mode.
class BrushToolbarItemWidget extends ToolbarItemWidget {
  const BrushToolbarItemWidget({required super.controller, super.key});

  @override
  SketchMode get mode => SketchMode.brush;

  @override
  bool get isActive => SketchMode.select == controller.mode;

  @override
  void onPressed(BuildContext context) {
    controller.setMode(mode);
    if (!painterController.isDrawing) {
      painterController.toggleDrawing();
    }
  }
}
