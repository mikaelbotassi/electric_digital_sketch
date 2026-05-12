import 'package:electric_digital_sketch/ui/add_edit_text_page.dart';
import 'package:flutter/material.dart';
import 'package:simple_painter/simple_painter.dart';

class ListenerService {
  late PainterController controller;
  late BuildContext context;
  Future<void> listen(
    PainterController painterController,
    BuildContext buildContext,
  ) async {
    controller = painterController;
    context = buildContext;
    painterController.eventListener((event) async {
      if (event is ItemPressEvent) {
        if (event.item is TextItem) {
          await changeTextItemValue(event.item as TextItem);
        } else if (event.item is ShapeItem) {
          await changeShapeItemValue(event.item as ShapeItem);
        }
      }
    });
  }

  Future<void> changeTextItemValue(TextItem item) async {
    final text = await Navigator.push(
      context,
      PageRouteBuilder<String>(
        opaque: false,
        pageBuilder: (context, animation, secondaryAnimation) =>
            AddEditTextPage(
          defaultText: item.text,
        ),
      ),
    );
    if(text == null) controller.removeItem(layerIndex: item.layer.index);
    final newItem = item.copyWith(text: text);
    controller.changeTextValues(newItem);
  }

  Future<void> changeShapeItemValue(ShapeItem item) async {
    var newItem = item;
    final type = item.shapeType;
    if (ShapeType.values.length - 1 == type.index) {
      newItem = item.copyWith(shapeType: ShapeType.values[0]);
    } else {
      newItem = item.copyWith(shapeType: ShapeType.values[type.index + 1]);
    }
    controller.changeShapeValues(newItem);
  }
}
