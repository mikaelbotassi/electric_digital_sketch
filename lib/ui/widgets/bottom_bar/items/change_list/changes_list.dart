import 'package:collection/collection.dart';
import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/change_list/change_list_item.dart';
import 'package:flutter/material.dart';

import 'package:simple_painter/simple_painter.dart';

class ChangesList extends StatelessWidget {
  const ChangesList({required this.controller, super.key});
  final PainterController controller;

  @override
  Widget build(BuildContext context) {
    final changeActions = controller.changeActions;
    if(changeActions.value.changeList.isEmpty) return const SizedBox.shrink();
    return ValueListenableBuilder(
      valueListenable: changeActions,
      builder: (context, value, _){
        final length = value.changeList.length;
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 8,
            children: value.changeList.reversed.mapIndexed((i, change) {
              final index = length - 1 - i;
              return ChangeListItem(
                controller: controller,
                index: index,
              );
            }).toList(),
          ),
        );
      }
    );
  }
}
