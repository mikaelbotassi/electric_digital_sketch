import 'package:electric_digital_sketch/domain/enums/sketch_mode.dart';
import 'package:electric_digital_sketch/ui/viewmodels/electric_sketch_controller.dart';
import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/brush_options.dart';
import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/change_list/changes_list.dart';
import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/erase_options.dart';
import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/select_options.dart';
import 'package:flutter/cupertino.dart';

class BottomBarContentFactory {
  static Widget build({
    required ElectricSketchController controller,
  }) {
    return switch (controller.mode) {
      SketchMode.changes => ChangesList(
        controller: controller.painterController,
      ),
      SketchMode.brush => BrushOptions(
        controller: controller.painterController,
      ),
      SketchMode.erase => EraseOptions(
        controller: controller.painterController,
      ),
      SketchMode.select => SelectOptions(
        controller: controller.painterController,
      ),
      _ => const SizedBox.shrink(),
    };
  }
}