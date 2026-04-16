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
    _mode = mode;
    notifyListeners();
  }

  bool _changeListIsOpen = false;
  bool get changeListIsOpen => _changeListIsOpen;
  void toggleChangeList() {
    _changeListIsOpen = !_changeListIsOpen;
    notifyListeners();
  }

  bool _settingsIsOpen = false;
  bool get settingsIsOpen => _settingsIsOpen;
  void toggleSettings() {
    _settingsIsOpen = !_settingsIsOpen;
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

  Future<void> importData() async {
    if(painterData.isEmpty) return;
    await painterController.importPainter(painterData);
    notifyListeners();
    return;
  }

  Future<Map<String, dynamic>> exportPainter() async {
    final painter = await painterController.exportPainter();
    return painter;
  }

  Map<String, dynamic> painterData = {};

  bool get isErasing => painterController.isErasing;
  void toggleErasing(){
    painterController.toggleErasing();
    notifyListeners();
  }

  bool get isDrawing => painterController.isDrawing;
  void toggleDrawing(){
    painterController.toggleDrawing();
    notifyListeners();
  }

  bool get editingText => painterController.editingText;
  bool get addingText => painterController.addingText;
  Future<void> addText(String text) async {
    await painterController.addText(text);
    notifyListeners();
  }

  bool _layersIsOpen = false;
  bool get layersIsOpen => _layersIsOpen;
  void toggleLayers() {
    _layersIsOpen = !_layersIsOpen;
    notifyListeners();
  }

  bool _shapesIsOpen = false;
  bool get shapesIsOpen => _shapesIsOpen;
  void toggleShapes() {
    _shapesIsOpen = !_shapesIsOpen;
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
