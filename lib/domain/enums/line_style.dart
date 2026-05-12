import 'package:electric_shapes/electric_shapes.dart';
import 'package:flutter/widgets.dart';

/// Visual styles available for electrical network lines.
enum LineStyle {
  redeMTProjetada(
    'Média Tensão Projetada',
    ElectricIcons.redeMediaTensaoProjetada,
  ),
  redeMTExistente(
    'Média Tensão Existente',
    ElectricIcons.redeMediaTensaoExistente,
  ),
  redeBTProjetada(
    'Baixa Tensão Projetada',
    ElectricIcons.redeBaixaTensaoProjetada,
  ),
  redeBTExistente(
    'Baixa Tensão Existente',
    ElectricIcons.redeBaixaTensaoExistente,
  )
  ;

  const LineStyle(this.label, this.icon);

  /// Human-readable label used in selection controls.
  final String label;

  /// Icon representing the line style.
  final IconData icon;
}
