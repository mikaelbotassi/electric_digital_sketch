import 'package:electric_digital_sketch/ui/widgets/core/primary_button.dart';
import 'package:electric_digital_sketch/ui/widgets/core/text_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

class AddTextPageBottom extends StatelessWidget {
  const AddTextPageBottom({required this.onConfirm, super.key});

  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.white24))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButtonWidget(
            icon: TablerIcons.x,
            text: 'Fechar',
            onPressed: () => Navigator.pop(context),
          ),
          PrimaryButton(
            icon: TablerIcons.check,
            text: 'Confirmar',
            onPressed: onConfirm,
          )
        ]
      ),
    );
  }
}
