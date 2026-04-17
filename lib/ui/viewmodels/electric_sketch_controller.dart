import 'dart:async';
import 'dart:typed_data';

import 'package:electric_digital_sketch/domain/enums/sketch_mode.dart';
import 'package:electric_digital_sketch/ui/add_edit_text_page.dart';
import 'package:electric_digital_sketch/ui/widgets/settings/custom_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:simple_painter/simple_painter.dart';

class ElectricSketchController extends ChangeNotifier {

  final painterController = PainterController();
  SketchMode _mode = SketchMode.select;
  SketchMode get mode => _mode;
  FutureOr<void> setMode(SketchMode mode, BuildContext context) async {
    _disablePainterTools();

    switch (mode) {
      case SketchMode.brush:
        _enableDrawing();
      case SketchMode.erase:
        _enableErasing();
      case SketchMode.select:
      case SketchMode.changes:
      case SketchMode.text:
        await _addText(context);
      case SketchMode.shapes:
      case SketchMode.layers:
    }

    _mode = mode;
    notifyListeners();
  }

  Future<void> _addText(BuildContext context) async {
    final text = await Navigator.push(
      context,
      PageRouteBuilder<String>(
        opaque: false,
        pageBuilder: (context, animation, secondaryAnimation) =>
          const AddEditTextPage(),
        transitionsBuilder:
          (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
    if(text != null && text.isNotEmpty) await painterController.addText(text);
  }

  void _disablePainterTools() {
    if (painterController.isErasing) {
      painterController.toggleErasing();
    }

    if (painterController.isDrawing) {
      painterController.toggleDrawing();
    }
  }

  void _enableDrawing() {
    if (!painterController.isDrawing) {
      painterController.toggleDrawing();
    }
  }

  void _enableErasing() {
    if (!painterController.isErasing) {
      painterController.toggleErasing();
    }
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
