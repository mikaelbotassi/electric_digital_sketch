import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  const TextInput({required this.controller, super.key});

  final TextEditingController controller;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {

  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.requestFocus();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      color: colors.surfaceContainerLowest,
      padding: const EdgeInsets.all(16),
      child: TextField(
        keyboardType: TextInputType.text,
        focusNode: focusNode,
        controller: widget.controller,
        autofocus: true,
        style: TextStyle(color: colors.onSurface),
        decoration: InputDecoration(
          fillColor: colors.surfaceContainerLowest,
          filled: true,
          border: InputBorder.none,
        ),
        maxLines: 40,
      ),
    );
  }
}
