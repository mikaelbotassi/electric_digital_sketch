import 'package:electric_digital_sketch/ui/viewmodels/electric_sketch_controller.dart';
import 'package:electric_digital_sketch/ui/widgets/bottom_bar/bottom_bar_content_factory.dart';
import 'package:flutter/material.dart';

class BottomBarWidget extends StatelessWidget {

  const BottomBarWidget({
    required this.controller,
    super.key
  });

  final ElectricSketchController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final (colors, textTheme) = (theme.colorScheme, theme.textTheme);
    final keyboardInset = MediaQuery.viewInsetsOf(context).bottom;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      padding: EdgeInsets.only(bottom: keyboardInset),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
          color: colors.surfaceContainerLowest,
        ),
        child: SafeArea(
          top: false,
          child: ClipRect(
            child: AnimatedSize(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: colors.surfaceBright),
                      ),
                    ),
                    child: Text(
                      controller.mode.title,
                      style: textTheme.bodyMedium?.apply(
                        color: colors.onSurfaceVariant.withAlpha(100),
                      ),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 300),
                    child: SingleChildScrollView(
                      child: BottomBarContentFactory.build(
                        controller: controller,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
