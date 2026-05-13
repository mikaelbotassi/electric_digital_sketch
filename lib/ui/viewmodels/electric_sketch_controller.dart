import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:electric_digital_sketch/domain/enums/line_style.dart';
import 'package:electric_digital_sketch/domain/enums/sketch_mode.dart';
import 'package:electric_digital_sketch/utils/extensions/painter_controller_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:simple_painter/simple_painter.dart';
import 'package:universal_io/io.dart';

/// Controller responsible for the editor state and export helpers.
///
/// It coordinates the active tool, line creation workflow and the underlying
/// [PainterController] used to manipulate the canvas.
class ElectricSketchController extends ChangeNotifier {
  ElectricSketchController() : painterController = PainterController();

  /// Default pixel ratio used when exporting the sketch as PNG.
  static const double defaultExportPixelRatio = 4;

  /// Underlying painter controller used to render and mutate the canvas.
  final PainterController painterController;
  Offset? _pendingLinePoint;
  LineStyle _lineStyle = LineStyle.redeBTExistente;
  SketchMode _mode = SketchMode.select;

  /// Currently active interaction mode in the editor.
  SketchMode get mode => _mode;

  /// First point waiting for the second tap when drawing network lines.
  Offset? get pendingLinePoint => _pendingLinePoint;

  /// Whether there is a pending first point for a network line.
  bool get hasPendingLinePoint => _pendingLinePoint != null;

  /// Selected visual style for newly created network lines.
  LineStyle get lineStyle => _lineStyle;

  /// Changes the active editor mode.
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

  /// Whether there is at least one action available to undo.
  bool get canUndo => painterController.changeActions.value.index >= 0;

  /// Undoes the most recent action, if available.
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

  /// Redoes the next action in history, if available.
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

  void setInitialBackgroundImage(Uint8List? image) {
    painterController.cacheBackgroundImage = null;
    painterController.background.image = image;
    painterController.refreshValue();
    notifyListeners();
  }

  /// Updates the line style used by [registerLinePoint].
  void setLineStyle(LineStyle value) {
    if (_lineStyle == value) return;
    _lineStyle = value;
    notifyListeners();
  }

  /// Clears the first pending point of the network line workflow.
  void clearPendingLinePoint() {
    if (_pendingLinePoint == null) return;
    _pendingLinePoint = null;
    notifyListeners();
  }

  /// Registers a point for the network line workflow.
  ///
  /// The first call stores the start point. The second call draws a line using
  /// the current brush settings and the selected [lineStyle].
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

  /// Renders the current sketch as PNG bytes.
  Future<Uint8List?> renderImageBytes({
    double pixelRatio = defaultExportPixelRatio,
  }) {
    final resolvedPixelRatio = pixelRatio > 0
        ? pixelRatio
        : ui.PlatformDispatcher.instance.views.first.devicePixelRatio;
    return painterController.renderImage(pixelRatio: resolvedPixelRatio);
  }

  /// Renders the current sketch as a temporary PNG file.
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

  /// Persists PNG bytes to a temporary file.
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

  /// Copies an exported PNG file to the user downloads directory when possible.
  ///
  /// On platforms where the downloads directory cannot be inferred, `null` is
  /// returned.
  static Future<File?> saveImageToDownloads(
    File sourceFile, {
    String fileNamePrefix = 'electric_sketch',
  }) async {
    final downloadsDirectory = _resolveDownloadsDirectory();
    if (downloadsDirectory == null) return null;

    if (!downloadsDirectory.existsSync()) {
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
