import 'package:electric_digital_sketch/domain/enums/sketch_mode.dart';
import 'package:electric_digital_sketch/ui/widgets/toolbar/items/toolbar_item_widget.dart';
import 'package:flutter/cupertino.dart';

class SelectToolbarItemWidget extends ToolbarItemWidget {

  const SelectToolbarItemWidget({required super.controller, super.key});

  @override
  SketchMode get mode => SketchMode.select;

  @override
  bool get isActive => SketchMode.select == controller.mode;

  @override
  void onPressed(BuildContext context) {
    controller.setMode(mode);
  }

}
