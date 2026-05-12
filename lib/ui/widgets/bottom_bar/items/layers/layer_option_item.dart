import 'package:electric_digital_sketch/ui/result_page.dart';
import 'package:electric_digital_sketch/ui/viewmodels/electric_sketch_controller.dart';
import 'package:electric_digital_sketch/ui/widgets/core/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:simple_painter/simple_painter.dart';
import 'package:simple_painter/src/controllers/items/painter_item.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

class LayerOptionItem extends StatelessWidget {
  const LayerOptionItem({
    required this.controller,
    required this.item,
    super.key,
  });

  final PainterController controller;
  final PainterItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final (colors, textTheme) = (theme.colorScheme, theme.textTheme);
    final isSelected = controller.value.selectedItem == item;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isSelected ? colors.primary : colors.onSurface.withAlpha(50),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              item.layer.title,
              style: textTheme.bodyMedium?.apply(color: colors.primary),
            ),
          ),
          IconButtonWidget(
            icon: TablerIcons.trash,
            color: colors.error,
            onPressed: () {
              controller.removeItem(layerIndex: item.layer.index);
            },
          ),
          IconButtonWidget(
            icon: TablerIcons.photo,
            color: colors.primary,
            onPressed: () async {
              final image = await controller.renderItem(
                item,
                enableRotation: true,
              );
              if (image == null) return;

              final imageFile =
                  await ElectricSketchController.writeImageBytesToTemp(
                    image,
                    fileNamePrefix: 'electric_sketch_layer',
                  );
              if (!context.mounted) return;

              await Navigator.push(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (context) => ResultPage(imageFile: imageFile),
                ),
              );
            },
          ),
          IconButtonWidget(
            icon: TablerIcons.arrowDown,
            onPressed: () {
              controller.updateLayerIndex(item, item.layer.index - 1);
            },
          ),
          IconButtonWidget(
            icon: TablerIcons.arrowUp,
            onPressed: () {
              controller.updateLayerIndex(item, item.layer.index + 1);
            },
          ),
        ],
      ),
    );
  }
}
