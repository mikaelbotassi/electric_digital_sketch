import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({required this.image, super.key});
  final Uint8List image;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Resultado',
          style: textTheme.titleLarge,
        ),
      ),
      body: Center(
        child: Image.memory(image),
      ),
    );
  }
}
