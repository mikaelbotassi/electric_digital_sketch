import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/shapes/electric_shapes/transformadores/transformador_projetado_symbol.dart';
import 'package:flutter/cupertino.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:simple_painter/simple_painter.dart';

enum ElectricShapeType {

  line(
    type: .line,
    icon: Icon(PhosphorIconsRegular.lineSegment),
    desc: 'Linha',
    group: 'Geral'
  ),
  arrow(
    type: .arrow,
    icon: Icon(PhosphorIconsRegular.arrowUpRight),
    desc: 'Seta',
    group: 'Geral'
  ),
  doubleArrow(
    type: .doubleArrow,
    icon: Icon(PhosphorIconsRegular.arrowsHorizontal),
    desc: 'Seta Dupla',
    group: 'Geral'
  ),
  rectangle(
    type: .rectangle,
    icon: Icon(PhosphorIconsRegular.rectangle),
    desc: 'Retângulo',
    group: 'Geral'
  ),
  triangle(
    type: .triangle,
    icon: Icon(PhosphorIconsRegular.triangle),
    desc: 'Triângulo',
    group: 'Geral'
  ),
  star(
    type: .star,
    icon: Icon(PhosphorIconsRegular.star),
    desc: 'Estrela',
    group: 'Geral'
  ),
  circle(
    type: .circle,
    icon: Icon(PhosphorIconsRegular.circle),
    desc: 'Círculo',
    group: 'Geral'
  ),
  transformadorExistente(
    customWidget: TransformadorProjetadoSymbol(),
    desc: 'Transformador Existente',
    group: 'Transformadores',
    icon: TransformadorProjetadoSymbol(size: 24)
  );

  const ElectricShapeType({
    required this.desc,
    required this.group,
    required this.icon,
    this.customWidget,
    this.type
  });

  final ShapeType? type;
  final Widget? customWidget;
  final Widget icon;
  final String desc;
  final String group;

  static Map<String,List<ElectricShapeType>> get groups{
    final map = <String, List<ElectricShapeType>>{};
    for(final shape in ElectricShapeType.values){
      if(map.keys.contains(shape.group)){
        map[shape.group]?.add(shape);
        continue;
      }
      map[shape.group] = [];
      map[shape.group]?.add(shape);
    }
    return map;
  }

  static List<ElectricShapeType> findByGroup(String group) =>
    groups[group] ?? [];

}
