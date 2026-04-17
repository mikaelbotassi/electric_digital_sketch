import 'dart:typed_data';

import 'package:electric_digital_sketch/domain/enums/sketch_mode.dart';
import 'package:electric_digital_sketch/ui/widgets/settings/custom_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:simple_painter/simple_painter.dart';

class ElectricSketchController extends ChangeNotifier {

  final painterController = PainterController();
  SketchMode _mode = SketchMode.select;
  SketchMode get mode => _mode;
  void setMode(SketchMode mode) {
    switch(mode){
      case SketchMode.erase:
        if(painterController.isDrawing) painterController.toggleDrawing();
        painterController.toggleErasing();
        break;
      case SketchMode.brush:
        if(painterController.isErasing) painterController.toggleErasing();
        painterController.toggleDrawing();
        break;
      case SketchMode.changes:
        if(painterController.isErasing) painterController.toggleErasing();
        if(painterController.isDrawing) painterController.toggleDrawing();
        break;
      default:
        if(painterController.isErasing) painterController.toggleErasing();
        if(painterController.isDrawing) painterController.toggleDrawing();
        break;
    }
    _mode = mode;
    notifyListeners();
  }

  void removeSelectedItem(){
    painterController.removeItem();
    notifyListeners();
  }

  bool get canUndo => painterController.changeActions.value.index >= 0;
  void undo(){
    painterController.undo();
    notifyListeners();
  }

  bool get canRedo{
    if(painterController.changeActions.value.changeList.isEmpty) return false;
    if(painterController.changeActions.value.index ==
        painterController.changeActions.value.changeList.length - 1){
      return false;
    }
    return true;
  }
  void redo(){
    painterController.redo();
    notifyListeners();
  }

  Future<void> addText(String text) async {
    await painterController.addText(text);
    notifyListeners();
  }

  Future<void> setBackgroundImage(Uint8List image) async {
    await painterController.setBackgroundImage(image);
    notifyListeners();
  }

  void addCustomWidget(CustomWidget customWidget) {
    painterController.addCustomWidget(customWidget);
    notifyListeners();
  }


}
