import 'package:flutter/material.dart';

class GradientStopHandle extends StatelessWidget {
  const GradientStopHandle({
    required this.color,
    required this.selected,
    required this.onTap,
    required this.onDragged,
    super.key,
  });

  final Color color;
  final bool selected;
  final VoidCallback onTap;
  final ValueChanged<DragUpdateDetails> onDragged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      onHorizontalDragStart: (_) => onTap(),
      onHorizontalDragUpdate: onDragged,
      child: Container(
        width: 16,
        height: 24,
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected ? colors.primary : colors.outlineVariant,
            width: selected ? 2 : 1,
          ),
        ),
        child: Center(
          child: Container(
            width: 18,
            height: 26,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: colors.outlineVariant),
            ),
          ),
        ),
      ),
    );
  }
}
