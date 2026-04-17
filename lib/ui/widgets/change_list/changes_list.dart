import 'package:collection/collection.dart';
import 'package:electric_digital_sketch/ui/widgets/change_list/change_list_item.dart';
import 'package:flutter/material.dart';

import 'package:simple_painter/simple_painter.dart';

class ChangesList extends StatefulWidget {
  const ChangesList({required this.controller, super.key});
  final PainterController controller;

  @override
  State<ChangesList> createState() => _ChangesListState();
}

class _ChangesListState extends State<ChangesList> {

  final scrollController = ScrollController();

  @override
  void initState() {
    widget.controller.changeActions.addListener(onActionsChanged);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.changeActions.removeListener(onActionsChanged);
    super.dispose();
  }

  void onActionsChanged(){
    final value = widget.controller.changeActions.value;
    setState(() {});
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (value.changeList.isNotEmpty &&
      value.index == value.changeList.length - 1) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final value = widget.controller.changeActions.value;
    if(value.changeList.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 8,
        children: value.changeList.mapIndexed((i, change) =>
          ChangeListItem(
            controller: widget.controller,
            index: i,
          )).toList(),
      ),
    );
  }

}
