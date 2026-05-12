import 'dart:async';
import 'dart:io';

import 'package:electric_digital_sketch/ui/widgets/core/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ConfirmButton extends StatefulWidget {
  const ConfirmButton({required this.file, this.onConfirm, super.key});

  final FutureOr<void> Function(File imageFile)? onConfirm;
  final File file;

  @override
  State<ConfirmButton> createState() => _ConfirmButtonState();
}

class _ConfirmButtonState extends State<ConfirmButton> {

  bool _isConfirming = false;

  Future<void> _confirmImage() async {
    final onConfirm = widget.onConfirm;
    if (onConfirm == null || _isConfirming) return;

    setState(() => _isConfirming = true);
    try {
      await onConfirm(widget.file);
    } finally {
      if (mounted) {
        setState(() => _isConfirming = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      icon: PhosphorIconsRegular.check,
      enabled: !_isConfirming,
      onPressed: _isConfirming ? null : _confirmImage,
    );
  }
}
