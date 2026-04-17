import 'package:electric_digital_sketch/domain/enums/sketch_mode.dart';
import 'package:electric_digital_sketch/ui/viewmodels/electric_sketch_controller.dart';
import 'package:electric_digital_sketch/ui/widgets/change_list/changes_list.dart';
import 'package:flutter/material.dart';

class BottomBarWidget extends StatelessWidget {

  const BottomBarWidget({
    required this.controller,
    super.key
  });

  final ElectricSketchController controller;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
        color: Colors.black,
      ),
      child: SafeArea(
        top: false,
        child: ClipRect(
          child: AnimatedSize(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.white24),
                    ),
                  ),
                  child: Text(
                    controller.mode.title,
                    style: textTheme.bodyMedium?.apply(color: Colors.grey),
                  ),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 300),
                  child: SingleChildScrollView(
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get child{
    if(controller.mode == SketchMode.changes){
      return ChangesList(controller: controller.painterController);
    }
    return const SizedBox.shrink();
  }

}
