import 'package:flutter/material.dart';

class DoubleSwitch extends StatefulWidget {
  const DoubleSwitch({
    required this.label,
    required this.initialValue,
    required this.onChanged,
    this.maxValue = 100,
    this.minValue = 0,
    this.ignore = false,
    super.key
  });

  final double initialValue;
  final double maxValue;
  final double minValue;
  final ValueChanged<double> onChanged;
  final bool ignore;
  final String label;

  @override
  State<DoubleSwitch> createState() => _DoubleSwitchState();
}

class _DoubleSwitchState extends State<DoubleSwitch> {

  late final ValueNotifier<double> doubleNotifier;

  @override
  void initState() {
    doubleNotifier = ValueNotifier<double>(widget.initialValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final (textTheme, colors) = (theme.textTheme, theme.colorScheme);
    return IgnorePointer(
      ignoring: widget.ignore,
      child: Opacity(
        opacity: widget.ignore ? 0.5 : 1,
        child: Row(
          children: [
            Text(
              widget.label,
              style: textTheme.bodyMedium?.apply(color: colors.onSurface)
            ),
            ValueListenableBuilder(
              valueListenable: doubleNotifier,
              builder: (context, colorVal, child) => Row(
                children: [
                  Slider(
                    value: colorVal,
                    max: widget.maxValue,
                    min: widget.minValue,
                    onChanged: (value) {
                      doubleNotifier.value = value;
                    },
                    onChangeEnd: widget.onChanged,
                  ),
                  Text(
                      '${doubleNotifier.value.toStringAsFixed(0)} px',
                      style: textTheme.bodyMedium?.apply(
                        color: colors.onSurface.withAlpha(100)
                      )
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
