import 'dart:async';
import 'package:electric_digital_sketch/ui/widgets/result_appbar/confirm_button.dart';
import 'package:electric_digital_sketch/ui/widgets/result_appbar/share_button.dart';
import 'package:flutter/material.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';
import 'package:universal_io/io.dart';

/// App bar shown on the result preview page.
class ResultAppbar extends StatelessWidget implements PreferredSizeWidget {
  const ResultAppbar({
    required this.file,
    this.onConfirm,
    super.key,
  });

  final FutureOr<void> Function(File imageFile)? onConfirm;
  final File file;

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final (colors, textTheme) = (theme.colorScheme, theme.textTheme);
    return Container(
      padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
      color: colors.surfaceContainerLowest,
      child: SafeArea(
        bottom: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 8,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    TablerIcons.chevronLeft,
                    color: colors.onSurfaceVariant,
                  ),
                ),
                Text(
                  'Resultado',
                  style: textTheme.titleLarge?.copyWith(color: colors.primary),
                ),
              ],
            ),
            Row(
              spacing: 8,
              children: [
                ShareButton(file: file),
                if (onConfirm != null)
                  ConfirmButton(file: file, onConfirm: onConfirm),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
