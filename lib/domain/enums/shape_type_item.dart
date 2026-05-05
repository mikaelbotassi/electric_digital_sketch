import 'package:flutter/cupertino.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:simple_painter/simple_painter.dart';

enum ShapeTypeItem {

  line(.line, PhosphorIconsRegular.lineSegment,'Linha'),
  arrow(.arrow, PhosphorIconsRegular.arrowUpRight,'Seta'),
  doubleArrow(.doubleArrow, PhosphorIconsRegular.arrowsHorizontal,'Seta Dupla'),
  rectangle(.rectangle, PhosphorIconsRegular.rectangle,'Retângulo'),
  triangle(.triangle, PhosphorIconsRegular.triangle,'Triângulo'),
  star(.star, PhosphorIconsRegular.star,'Estrela'),
  circle(.circle, PhosphorIconsRegular.circle,'Círculo');

  const ShapeTypeItem(this.type, this.icon, this.desc);

  final ShapeType type;
  final String desc;
  final IconData icon;

}
