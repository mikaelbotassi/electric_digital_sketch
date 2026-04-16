import 'package:electric_digital_sketch/domain/enums/sketch_mode.dart';
import 'package:electric_digital_sketch/ui/viewmodels/electric_sketch_controller.dart';
import 'package:electric_digital_sketch/ui/widgets/toolbar/toolbar_item_widget.dart';
import 'package:flutter/material.dart';

class ToolbarWidget extends StatelessWidget {

  const ToolbarWidget({required this.controller, super.key});

  final ElectricSketchController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade900.withAlpha(50),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ]
      ),
      child: Column(
        spacing: 8,
        children: items,
      ),
    );
  }

  List<Widget> get items => SketchMode.values.map((mode) =>
    ToolbarItemWidget(mode: mode, controller: controller)).toList();

}
