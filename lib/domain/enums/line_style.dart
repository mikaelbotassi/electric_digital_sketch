import 'package:electric_shapes/electric_shapes.dart';
import 'package:flutter/widgets.dart';

enum LineStyle {
  redeMTProjetada('Média Tensão Projetada', ElectricIcons.redeMediaTensaoProjetada),
  redeMTExistente('Média Tensão Existente', ElectricIcons.redeMediaTensaoExistente),
  redeBTProjetada('Baixa Tensão Projetada', ElectricIcons.redeBaixaTensaoProjetada),
  redeBTExistente('Baixa Tensão Existente', ElectricIcons.redeBaixaTensaoExistente);

  const LineStyle(this.label, this.icon);

  final String label;
  final IconData icon;
}
