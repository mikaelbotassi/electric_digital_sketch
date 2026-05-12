import 'dart:math' as math;

import 'package:electric_digital_sketch/domain/enums/line_style.dart';
import 'package:flutter/material.dart';
import 'package:simple_painter/simple_painter.dart';
import 'package:simple_painter/src/models/brush_model.dart';

/// Convenience helpers that adapt `simple_painter` to the package workflow.
extension PainterControllerExtension on PainterController {
  void addBorderlessCustomWidget(Widget widget, [String? layerTitle]) {
    addCustomWidget(widget, layerTitle: layerTitle);
    final item = value.selectedItem;
    if (item is CustomWidgetItem) {
      changeCustomWidgetValues(
        item,
        borderWidth: 0,
        borderColor: Colors.transparent,
        borderRadius: BorderRadius.zero,
      );
    }
    return;
  }

  void drawLine(
    Offset start,
    Offset end, {
    Color color = Colors.black,
    double thickness = 2,
    LineStyle style = LineStyle.redeBTExistente,
    String? layerTitle,
  }) {
    if (start == end) return;

    final resolvedThickness = _resolveThickness(style, thickness);
    final path = switch (style) {
      LineStyle.redeMTProjetada => _buildDashedPath(
        start: start,
        end: end,
        color: color,
        thickness: resolvedThickness,
        dashLength: 28,
        gapLength: 14,
      ),
      LineStyle.redeMTExistente => _buildDashedPath(
        start: start,
        end: end,
        color: color,
        thickness: resolvedThickness,
        dashLength: 18,
        gapLength: 10,
      ),
      LineStyle.redeBTProjetada => <DrawModel?>[
        DrawModel(
          offset: start,
          color: color,
          strokeWidth: resolvedThickness,
        ),
        DrawModel(
          offset: end,
          color: color,
          strokeWidth: resolvedThickness,
        ),
      ],
      LineStyle.redeBTExistente => <DrawModel?>[
        DrawModel(
          offset: start,
          color: color,
          strokeWidth: resolvedThickness,
        ),
        DrawModel(
          offset: end,
          color: color,
          strokeWidth: resolvedThickness,
        ),
      ],
    };

    value = value.copyWith(
      currentPaintPath: path,
    );
    endPath();
  }
}

List<DrawModel?> _buildDashedPath({
  required Offset start,
  required Offset end,
  required Color color,
  required double thickness,
  required double dashLength,
  required double gapLength,
}) {
  final delta = end - start;
  final distance = delta.distance;
  if (distance == 0) {
    return const [];
  }

  final direction = Offset(delta.dx / distance, delta.dy / distance);
  final path = <DrawModel?>[];

  var drawn = 0.0;
  while (drawn < distance) {
    final dashStart =
        start + Offset(direction.dx * drawn, direction.dy * drawn);
    final dashEndDistance = (drawn + dashLength) > distance
        ? distance
        : (drawn + dashLength);
    final dashEnd =
        start +
        Offset(
          direction.dx * dashEndDistance,
          direction.dy * dashEndDistance,
        );

    path
      ..add(
        DrawModel(
          offset: dashStart,
          color: color,
          strokeWidth: thickness,
        ),
      )
      ..add(
        DrawModel(
          offset: dashEnd,
          color: color,
          strokeWidth: thickness,
        ),
      );

    if (dashEndDistance < distance) {
      path.add(null);
    }

    drawn = dashEndDistance + gapLength;
  }

  return path;
}

double _resolveThickness(LineStyle style, double thickness) {
  return switch (style) {
    LineStyle.redeMTProjetada => math.max(thickness, 4),
    LineStyle.redeMTExistente => math.max(thickness * 0.8, 2),
    LineStyle.redeBTProjetada => math.max(thickness, 4),
    LineStyle.redeBTExistente => math.max(thickness * 0.45, 1),
  };
}
