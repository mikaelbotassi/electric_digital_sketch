import 'dart:async';

import 'package:electric_digital_sketch/ui/widgets/result_appbar/result_appbar.dart';
import 'package:flutter/material.dart';
import 'package:universal_io/io.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({
    required this.imageFile,
    this.onConfirm,
    super.key,
  });

  final File imageFile;
  final FutureOr<void> Function(File imageFile)? onConfirm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResultAppbar(file: imageFile, onConfirm: onConfirm),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Image.file(imageFile),
          ),
        ),
      ),
    );
  }
}
