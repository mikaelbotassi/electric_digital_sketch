import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:electric_digital_sketch/domain/enums/line_style.dart';
import 'package:electric_digital_sketch/domain/enums/sketch_mode.dart';
import 'package:electric_digital_sketch/utils/extensions/painter_controller_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:simple_painter/simple_painter.dart';
import 'package:universal_io/io.dart';

class ElectricSketchController extends ChangeNotifier {
  static const double defaultExportPixelRatio = 4;

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
    if (mode == this.mode) return;
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

  void removeSelectedItem() {
    painterController.removeItem();
    notifyListeners();
  }

  bool get canUndo => painterController.changeActions.value.index >= 0;
  void undo() {
    painterController.undo();
    notifyListeners();
  }

  bool get canRedo {
    if (painterController.changeActions.value.changeList.isEmpty) return false;
    if (painterController.changeActions.value.index ==
        painterController.changeActions.value.changeList.length - 1) {
      return false;
    }
    return true;
  }

  void redo() {
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

  Future<Uint8List?> renderImageBytes({
    double pixelRatio = defaultExportPixelRatio,
  }) {
    final resolvedPixelRatio = pixelRatio > 0
        ? pixelRatio
        : ui.PlatformDispatcher.instance.views.first.devicePixelRatio;
    return painterController.renderImage(pixelRatio: resolvedPixelRatio);
  }

  Future<File?> renderImageFile({
    double pixelRatio = defaultExportPixelRatio,
    String fileNamePrefix = 'electric_sketch',
  }) async {
    final imageBytes = await renderImageBytes(pixelRatio: pixelRatio);
    if (imageBytes == null) return null;
    return writeImageBytesToTemp(
      imageBytes,
      fileNamePrefix: fileNamePrefix,
    );
  }

  static Future<File> writeImageBytesToTemp(
    Uint8List imageBytes, {
    String fileNamePrefix = 'electric_sketch',
  }) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final path = [
      Directory.systemTemp.path,
      '$fileNamePrefix-$timestamp.png',
    ].join(Platform.pathSeparator);
    final file = File(path);
    await file.writeAsBytes(imageBytes, flush: true);
    return file;
  }

  static Future<File?> saveImageToDownloads(
    File sourceFile, {
    String fileNamePrefix = 'electric_sketch',
  }) async {
    final downloadsDirectory = _resolveDownloadsDirectory();
    if (downloadsDirectory == null) return null;

    if (!await downloadsDirectory.exists()) {
      await downloadsDirectory.create(recursive: true);
    }

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final targetPath = [
      downloadsDirectory.path,
      '$fileNamePrefix-$timestamp.png',
    ].join(Platform.pathSeparator);

    return sourceFile.copy(targetPath);
  }

  static Directory? _resolveDownloadsDirectory() {
    if (Platform.isAndroid) {
      return Directory('/storage/emulated/0/Download');
    }

    if (Platform.isIOS) {
      return null;
    }

    final home =
        Platform.environment['USERPROFILE'] ?? Platform.environment['HOME'];
    if (home == null || home.isEmpty) {
      return null;
    }

    return Platform.isWindows
        ? Directory('$home\\Downloads')
        : Directory('$home/Downloads');
  }
}
