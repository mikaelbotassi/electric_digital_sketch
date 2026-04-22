import 'package:electric_digital_sketch/domain/enums/sketch_mode.dart';
import 'package:electric_digital_sketch/ui/widgets/toolbar/items/toolbar_item_widget.dart';
import 'package:flutter/cupertino.dart';

class ChangesToolbarItemWidget extends ToolbarItemWidget {

  const ChangesToolbarItemWidget({required super.controller, super.key});

  @override
  SketchMode get mode => SketchMode.changes;

  @override
  bool get isActive => SketchMode.select == controller.mode;

  @override
  void onPressed(BuildContext context) {
    controller.setMode(mode);
  }

}
