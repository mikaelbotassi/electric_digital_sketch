import 'dart:async';
import 'dart:typed_data';
import 'package:electric_digital_sketch/domain/enums/line_style.dart';
import 'package:electric_digital_sketch/domain/enums/sketch_mode.dart';
import 'package:electric_digital_sketch/utils/extensions/painter_controller_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:simple_painter/simple_painter.dart';

class ElectricSketchController extends ChangeNotifier {

  final painterController = PainterController();
  Offset? _pendingLinePoint;
  LineStyle _lineStyle = LineStyle.redeBTExistente;
  SketchMode _mode = SketchMode.select;
  SketchMode get mode => _mode;
  Offset? get pendingLinePoint => _pendingLinePoint;
  bool get hasPendingLinePoint => _pendingLinePoint != null;
  LineStyle get lineStyle => _lineStyle;
  void setMode(SketchMode mode) {
    _disablePainterTools();
    if(mode == this.mode) return;
    if (mode != SketchMode.redes) {
      _pendingLinePoint = null;
    }
    _mode = mode;
    notifyListeners();
  }

  void _disablePainterTools() {
    if (painterController.isErasing) {
      painterController.toggleErasing();
    }

    if (painterController.isDrawing) {
      painterController.toggleDrawing();
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

  void setLineStyle(LineStyle value) {
    if (_lineStyle == value) return;
    _lineStyle = value;
    notifyListeners();
  }

  void clearPendingLinePoint() {
    if (_pendingLinePoint == null) return;
    _pendingLinePoint = null;
    notifyListeners();
  }

  void registerLinePoint(Offset point) {
    if (_mode != SketchMode.redes) return;

    final start = _pendingLinePoint;
    if (start == null) {
      _pendingLinePoint = point;
      notifyListeners();
      return;
    }

    painterController.drawLine(
      start,
      point,
      color: painterController.value.brushColor,
      thickness: painterController.value.brushSize,
      style: _lineStyle,
    );
    _pendingLinePoint = null;
    notifyListeners();
  }


}
