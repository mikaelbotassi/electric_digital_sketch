import 'package:flutter/material.dart';
import 'package:simple_painter/simple_painter.dart';

class ChangeListItem extends StatelessWidget {
  const ChangeListItem({
    required this.index,
    required this.controller,
    super.key
  });

  final int index;
  final PainterController controller;

  @override
  Widget build(BuildContext context) {
    final value = controller.changeActions.value;
    final theme = Theme.of(context);
    final (textTheme,colors) = (theme.textTheme, theme.colorScheme);
    final text = actionTypeToString(value.changeList[index].actionType);
    return GestureDetector(
      onTap: () => controller.updateActionWithChangeActionIndex(index),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: value.index == index ? colors.primary : null,
          border: Border(
            bottom: BorderSide(color: colors.primary),
            top: BorderSide(color: colors.primary),
            right: BorderSide(color: colors.primary),
            left: BorderSide(color: colors.primary, width: 4)
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(text,
          style: textTheme.bodyMedium?.apply(color: Colors.white),
        ),
      ),
    );
  }

  String actionTypeToString(ActionType actionType) {
    switch (actionType) {
      case ActionType.addedTextItem:
        return 'Texto adicionado';
      case ActionType.addedImageItem:
        return 'Imagem adicionada';
      case ActionType.positionItem:
        return 'Posição alterada';
      case ActionType.addedCustomWidgetItem:
        return 'Widget personalizado adicionado';
      case ActionType.sizeItem:
        return 'Tamanho alterado';
      case ActionType.rotationItem:
        return 'Rotação alterada';
      case ActionType.changedLayerIndex:
        return 'Camada alterada';
      case ActionType.removedItem:
        return 'Item removido';
      case ActionType.draw:
        return 'Desenho feito';
      case ActionType.erase:
        return 'Apagado';
      case ActionType.changeTextValue:
        return 'Texto editado';
      case ActionType.changeImageValue:
        return 'Imagem editada';
      case ActionType.changeShapeValue:
        return 'Forma editada';
      case ActionType.addedShapeItem:
        return 'Forma adicionada';
      case ActionType.changeCustomWidgetValue:
        return 'Widget personalizado editado';
      case ActionType.changeBackgroundImage:
        return 'Imagem de fundo alterada';
      case ActionType.importPainter:
        return 'Pintura importada';
    }
  }

}
