import 'package:electric_digital_sketch/domain/enums/sketch_mode.dart';
import 'package:electric_digital_sketch/ui/viewmodels/electric_sketch_controller.dart';
import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/brush_options/brush_options.dart';
import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/change_list/changes_list.dart';
import 'package:flutter/material.dart';

class BottomBarBodyWidget extends StatelessWidget {

  const BottomBarBodyWidget({required this.controller, super.key});

  final ElectricSketchController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: controller.painterController.changeActions,
        builder: (context, value, _){
          if(controller.mode == SketchMode.changes){
            return ChangesList(controller: controller.painterController);
          }
          if(controller.mode == SketchMode.brush){
            return BrushOptions(controller: controller.painterController);
          }
          return const SizedBox.shrink();
        }
    );
  }
}
