import 'dart:async';

import 'package:electric_digital_sketch/domain/enums/sketch_mode.dart';
import 'package:electric_digital_sketch/ui/viewmodels/electric_sketch_controller.dart';
import 'package:electric_digital_sketch/ui/widgets/app_bar/app_bar_widget.dart';
import 'package:electric_digital_sketch/ui/widgets/bottom_bar/bottom_bar_widget.dart';
import 'package:electric_digital_sketch/ui/widgets/toolbar/toolbar_widget.dart';
import 'package:electric_digital_sketch/utils/helpers/listener_service.dart';
import 'package:flutter/material.dart';
import 'package:simple_painter/simple_painter.dart';
import 'package:universal_io/io.dart';

/// Main editor page exposed by the package.
///
/// This widget wraps the painter canvas, toolbar, bottom options and result
/// flow used to create and export electrical sketches.
class ElectricSketchPage extends StatefulWidget {
  /// Creates the editor page.
  ///
  /// When [onConfirm] is provided, the generated image file is returned after
  /// the user confirms the exported result.
  const ElectricSketchPage({
    this.onConfirm,
    super.key,
  });

  /// Called when the user confirms the generated result image.
  final FutureOr<void> Function(File imageFile)? onConfirm;

  @override
  State<ElectricSketchPage> createState() => _ElectricSketchPageState();
}

class _ElectricSketchPageState extends State<ElectricSketchPage> {
  final ElectricSketchController controller = ElectricSketchController();
  final GlobalKey _overlayKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    unawaited(ListenerService().listen(controller.painterController, context));
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBarWidget(
          controller: controller,
          onConfirm: widget.onConfirm,
        ),
        bottomNavigationBar: BottomBarWidget(controller: controller),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              key: _overlayKey,
              children: [
                SizedBox.expand(
                  child: PainterWidget(
                    controller: controller.painterController,
                    boundaryMargin: 0,
                  ),
                ),
                if (controller.mode == SketchMode.redes)
                  Positioned.fill(
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTapUp: (details) {
                        final point = _toCanvasOffsetFromGlobal(
                          controller.painterController.repaintBoundaryKey,
                          details.globalPosition,
                        );
                        if (point != null) {
                          controller.registerLinePoint(point);
                        }
                      },
                      child: controller.hasPendingLinePoint
                          ? CustomPaint(
                              painter: _PendingLinePointPainter(
                                point: _toOverlayOffsetFromCanvas(
                                  overlayKey: _overlayKey,
                                  canvasKey: controller
                                      .painterController
                                      .repaintBoundaryKey,
                                  canvasPoint: controller.pendingLinePoint!,
                                ),
                              ),
                              child: const SizedBox.expand(),
                            )
                          : const SizedBox.expand(),
                    ),
                  ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: ToolbarWidget(controller: controller),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

Offset? _toCanvasOffsetFromGlobal(GlobalKey canvasKey, Offset globalPoint) {
  final context = canvasKey.currentContext;
  if (context == null) {
    return null;
  }

  final renderObject = context.findRenderObject();
  if (renderObject is! RenderBox) {
    return null;
  }

  final local = renderObject.globalToLocal(globalPoint);
  final size = renderObject.size;
  if (local.dx < 0 ||
      local.dy < 0 ||
      local.dx > size.width ||
      local.dy > size.height) {
    return null;
  }

  return local;
}

Offset _toOverlayOffsetFromCanvas({
  required GlobalKey overlayKey,
  required GlobalKey canvasKey,
  required Offset canvasPoint,
}) {
  final overlayContext = overlayKey.currentContext;
  final canvasContext = canvasKey.currentContext;
  if (overlayContext == null || canvasContext == null) {
    return canvasPoint;
  }

  final overlayRenderObject = overlayContext.findRenderObject();
  final canvasRenderObject = canvasContext.findRenderObject();
  if (overlayRenderObject is! RenderBox || canvasRenderObject is! RenderBox) {
    return canvasPoint;
  }

  final global = canvasRenderObject.localToGlobal(canvasPoint);
  return overlayRenderObject.globalToLocal(global);
}

class _PendingLinePointPainter extends CustomPainter {
  const _PendingLinePointPainter({required this.point});

  final Offset point;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.red;
    canvas.drawCircle(point, 6, paint);
  }

  @override
  bool shouldRepaint(covariant _PendingLinePointPainter oldDelegate) {
    return oldDelegate.point != point;
  }
}
