import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/shapes/electric_shapes/redes/rede_baixa_tensao.dart';
import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/shapes/electric_shapes/redes/rede_media_tensao.dart';
import 'package:flutter/widgets.dart';

enum LineStyle {
  redeMTProjetada(
    'Rede MT Projetada',
    RedeMediaTensaoSymbol(size: 24)
  ),
  redeMTExistente(
    'Rede MT Existente',
    RedeMediaTensaoSymbol(size: 24, strokeWidth: 2)
  ),
  redeBTProjetada(
    'Rede BT Projetada',
    RedeBaixaTensaoSymbol(size: 24)
  ),
  redeBTExistente(
    'Rede BT Existente',
    RedeBaixaTensaoSymbol(size: 24,strokeWidth: 2,)
  );

  const LineStyle(this.label, this.icon);

  final String label;
  final Widget icon;
}
