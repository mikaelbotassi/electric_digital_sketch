import 'package:electric_digital_sketch/domain/enums/sketch_mode.dart';
import 'package:electric_digital_sketch/ui/widgets/toolbar/items/toolbar_item_widget.dart';
import 'package:flutter/cupertino.dart';

class LineToolbarItemWidget extends ToolbarItemWidget {
  const LineToolbarItemWidget({required super.controller, super.key});

  @override
  SketchMode get mode => SketchMode.redes;

  @override
  void onPressed(BuildContext context) {
    controller.setMode(mode);
  }
}
