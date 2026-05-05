import 'package:flutter/material.dart';
import 'package:simple_painter/simple_painter.dart';

extension PainterControllerExtension on PainterController{

  void addBorderlessCustomWidget(Widget widget, [String? layerTitle]){
    addCustomWidget(widget, layerTitle: layerTitle);
    final item = value.selectedItem;
    if(item is CustomWidgetItem){
      changeCustomWidgetValues(
        item,
        borderWidth: 0,
        borderColor: Colors.transparent,
        borderRadius: BorderRadius.zero
      );
    }
    return;
  }

}
