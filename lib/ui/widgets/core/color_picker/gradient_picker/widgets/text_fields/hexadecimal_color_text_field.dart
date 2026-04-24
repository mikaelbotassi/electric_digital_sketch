import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HexadecimalColorTextField extends StatefulWidget {
  const HexadecimalColorTextField({
    required this.textStyle,
    required this.hexadecimalController,
    this.onHexadecimalSubmitted,
    super.key,
  });

  final TextEditingController hexadecimalController;
  final ValueChanged<String>? onHexadecimalSubmitted;
  final TextStyle? textStyle;

  @override
  State<HexadecimalColorTextField> createState() =>
    _HexadecimalColorTextFieldState();
}

class _HexadecimalColorTextFieldState extends State<HexadecimalColorTextField> {
  @override
  void initState() {
    super.initState();
    _normalizeValue();
  }

  @override
  void didUpdateWidget(covariant HexadecimalColorTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.hexadecimalController != widget.hexadecimalController) {
      _normalizeValue();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return SizedBox(
      width: 72,
      child: TextFormField(
        style: widget.textStyle,
        controller: widget.hexadecimalController,
        maxLength: 6,
        textInputAction: TextInputAction.done,
        textAlignVertical: TextAlignVertical.center,
        onFieldSubmitted: widget.onHexadecimalSubmitted,
        decoration: InputDecoration(
          isDense: true,
          counterText: '',
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          prefixText: '# ',
          prefixStyle: widget.textStyle?.
            apply(color: colors.onSurface.withAlpha(100))
        ),
        inputFormatters: [
          FilteringTextInputFormatter.allow(
            RegExp('[0-9a-fA-F]'),
          ),
          UpperCaseTextFormatter(),
        ],
      ),
    );
  }

  void _normalizeValue() {
    final normalizedValue = widget.hexadecimalController.text
        .replaceAll('#', '')
        .toUpperCase();
    if (widget.hexadecimalController.text == normalizedValue) {
      return;
    }

    widget.hexadecimalController.value =
        widget.hexadecimalController.value.copyWith(
      text: normalizedValue,
      selection: TextSelection.collapsed(offset: normalizedValue.length),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
