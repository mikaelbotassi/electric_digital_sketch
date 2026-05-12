import 'package:electric_digital_sketch/ui/viewmodels/electric_sketch_controller.dart';
import 'package:electric_digital_sketch/ui/widgets/toolbar/items/brush_toolbar_item_widget.dart';
import 'package:electric_digital_sketch/ui/widgets/toolbar/items/changes_toolbar_item_widget.dart';
import 'package:electric_digital_sketch/ui/widgets/toolbar/items/erase_toolbar_item_widget.dart';
import 'package:electric_digital_sketch/ui/widgets/toolbar/items/layer_toolbar_item_widget.dart';
import 'package:electric_digital_sketch/ui/widgets/toolbar/items/line_toolbar_item_widget.dart';
import 'package:electric_digital_sketch/ui/widgets/toolbar/items/select_toolbar_item_widget.dart';
import 'package:electric_digital_sketch/ui/widgets/toolbar/items/shapes_toolbar_item_widget.dart';
import 'package:electric_digital_sketch/ui/widgets/toolbar/items/text_toolbar_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

/// Floating vertical toolbar used to switch editor modes.
class ToolbarWidget extends StatefulWidget {
  const ToolbarWidget({
    required this.controller,
    this.collapsed = false,
    super.key,
  });

  final ElectricSketchController controller;
  final bool collapsed;

  @override
  State<ToolbarWidget> createState() => _ToolbarWidgetState();
}

class _ToolbarWidgetState extends State<ToolbarWidget> {
  static const double _toolbarWidth = 56;
  static const double _toolbarPadding = 8;
  static const double _toolbarItemSpacing = 8;

  bool _collapsed = false;

  @override
  void initState() {
    _collapsed = widget.collapsed;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: _toolbarWidth,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade900.withAlpha(50),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () => setState(() => _collapsed = !_collapsed),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: _collapsed ? 16 : 8,
              ),
              decoration: BoxDecoration(
                color: colors.primary,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(
                _collapsed ? TablerIcons.chevronDown : TablerIcons.chevronUp,
                color: colors.onPrimary,
              ),
            ),
          ),
          TweenAnimationBuilder<double>(
            tween: Tween<double>(end: _collapsed ? 0 : 1),
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            child: Container(
              padding: const EdgeInsets.all(_toolbarPadding),
              decoration: BoxDecoration(
                color: colors.surfaceContainerLowest,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(4),
                ),
              ),
              child: Column(
                spacing: _toolbarItemSpacing,
                children: [
                  SelectToolbarItemWidget(controller: widget.controller),
                  BrushToolbarItemWidget(controller: widget.controller),
                  EraseToolbarItemWidget(controller: widget.controller),
                  LineToolbarItemWidget(controller: widget.controller),
                  ChangesToolbarItemWidget(controller: widget.controller),
                  TextToolbarItemWidget(controller: widget.controller),
                  LayerToolbarItemWidget(controller: widget.controller),
                  ShapesToolbarItemWidget(controller: widget.controller),
                ],
              ),
            ),
            builder: (context, factor, child) {
              return ClipRect(
                child: Align(
                  alignment: Alignment.topCenter,
                  heightFactor: factor,
                  child: child,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
