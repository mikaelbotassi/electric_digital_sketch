import 'package:electric_digital_sketch/ui/widgets/core/borderless_input.dart';
import 'package:flutter/material.dart';

class DescInput extends StatefulWidget {
  const DescInput({
    required this.onChanged,
    this.initialValue,
    super.key
  });

  final String? initialValue;
  final ValueChanged<String> onChanged;

  @override
  State<DescInput> createState() => _DescInputState();
}

class _DescInputState extends State<DescInput> {

  late final TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(text: widget.initialValue ?? '');
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: .start,
      spacing: 8,
      children: [
        const Text('Descrição'),
        Container(
          padding: const EdgeInsets.only(left: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: colors.outline.withAlpha(100))
          ),
          child: BorderlessInput(
            label: 'Texto',
            controller: controller,
            onChanged: widget.onChanged,
            maxLines: 3,
          ),
        ),
      ],
    );
  }
}
