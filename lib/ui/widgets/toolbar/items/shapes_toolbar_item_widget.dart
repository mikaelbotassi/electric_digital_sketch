import 'package:electric_digital_sketch/domain/enums/sketch_mode.dart';
import 'package:electric_digital_sketch/ui/widgets/toolbar/items/toolbar_item_widget.dart';
import 'package:flutter/cupertino.dart';

/// Toolbar entry that opens the shapes panel.
class ShapesToolbarItemWidget extends ToolbarItemWidget {
  const ShapesToolbarItemWidget({required super.controller, super.key});

  @override
  SketchMode get mode => SketchMode.shapes;

  @override
  void onPressed(BuildContext context) {
    controller.setMode(mode);
  }
}
