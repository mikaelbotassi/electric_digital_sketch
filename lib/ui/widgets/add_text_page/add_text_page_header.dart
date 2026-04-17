import 'package:electric_digital_sketch/ui/widgets/core/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

class AddTextPageHeader extends StatelessWidget {
  const AddTextPageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final (colors, textTheme) = (theme.colorScheme, theme.textTheme);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white24))
      ),
      child: Row(
        spacing: 32,
        children: [
          IconButtonWidget(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: TablerIcons.x,
          ),
          Text(
            'Adicionar Texto',
            style: textTheme.titleLarge?.apply(color: Colors.white)
          )
        ]
      ),
    );
  }
}
