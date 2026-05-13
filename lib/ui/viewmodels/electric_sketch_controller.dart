import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:electric_digital_sketch/domain/enums/line_style.dart';
import 'package:electric_digital_sketch/domain/enums/sketch_mode.dart';
import 'package:electric_digital_sketch/utils/extensions/painter_controller_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:simple_painter/simple_painter.dart';
// The package does not expose background sizing publicly, so this import is
// required to keep the initial image canvas aligned with the image ratio.
// ignore: implementation_imports
import 'package:simple_painter/src/controllers/drawables/background/painter_background.dart';
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
  late final Size _defaultCanvasSize = painterController.value.settings.size;
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
    _applyBackgroundSize(image);
    await painterController.setBackgroundImage(image);
    notifyListeners();
  }

  void setInitialBackgroundImage(Uint8List? image) {
    painterController.cacheBackgroundImage = null;
    painterController.background.image = image;
    _applyBackgroundSize(image);
    painterController.refreshValue();
    notifyListeners();
  }

  void _applyBackgroundSize(Uint8List? image) {
    if (image == null) {
      _updateCanvasSize(_defaultCanvasSize);
      painterController.background = PainterBackground(
        width: _defaultCanvasSize.width,
        height: _defaultCanvasSize.height,
      );
      return;
    }

    final imageSize = _decodeImageSize(image) ?? _defaultCanvasSize;
    _updateCanvasSize(imageSize);
    painterController.background = PainterBackground(
      image: image,
      width: imageSize.width,
      height: imageSize.height,
    );
  }

  Size? _decodeImageSize(Uint8List image) {
    if (image.length >= 24 &&
        image[0] == 0x89 &&
        image[1] == 0x50 &&
        image[2] == 0x4E &&
        image[3] == 0x47) {
      final data = ByteData.sublistView(image);
      return Size(
        data.getUint32(16).toDouble(),
        data.getUint32(20).toDouble(),
      );
    }

    if (image.length >= 2 && image[0] == 0xFF && image[1] == 0xD8) {
      var offset = 2;
      while (offset + 8 < image.length) {
        if (image[offset] != 0xFF) {
          offset++;
          continue;
        }

        final marker = image[offset + 1];
        offset += 2;

        if (marker == 0xD8 || marker == 0xD9) {
          continue;
        }

        if (offset + 2 > image.length) {
          break;
        }

        final length = (image[offset] << 8) | image[offset + 1];
        if (length < 2 || offset + length > image.length) {
          break;
        }

        final isStartOfFrame =
            marker >= 0xC0 &&
            marker <= 0xCF &&
            marker != 0xC4 &&
            marker != 0xC8 &&
            marker != 0xCC;
        if (isStartOfFrame) {
          return Size(
            ((image[offset + 5] << 8) | image[offset + 6]).toDouble(),
            ((image[offset + 3] << 8) | image[offset + 4]).toDouble(),
          );
        }

        offset += length;
      }
    }

    return null;
  }

  void _updateCanvasSize(Size size) {
    final settings = painterController.value.settings;
    painterController.value = painterController.value.copyWith(
      settings: PainterSettings(
        text: settings.text,
        brush: settings.brush,
        erase: settings.erase,
        size: size,
        itemDragHandleColor: settings.itemDragHandleColor,
      ),
    );
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
