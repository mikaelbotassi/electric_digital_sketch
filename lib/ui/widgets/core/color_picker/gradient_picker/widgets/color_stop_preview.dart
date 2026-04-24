import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorStopPreview extends StatelessWidget {
  const ColorStopPreview({
    required this.label,
    required this.color,
    this.size = const Size(32,32),
    super.key,
  });

  final String label;
  final Color color;
  final Size size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Flexible(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: colors.outlineVariant),
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              '$label ${color.toHexString().replaceRange(0, 2, '#')}',
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
