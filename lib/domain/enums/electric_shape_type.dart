import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/shapes/electric_shapes/aterramentos/aterramento_existente_symbol.dart';
import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/shapes/electric_shapes/aterramentos/aterramento_projetado_symbol.dart';
import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/shapes/electric_shapes/para_raios/para_raios_existente_symbol.dart';
import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/shapes/electric_shapes/para_raios/para_raios_projetado_symbol.dart';
import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/shapes/electric_shapes/postes/poste_concreto_circular_existente_symbol.dart';
import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/shapes/electric_shapes/postes/poste_concreto_circular_projetado_symbol.dart';
import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/shapes/electric_shapes/postes/poste_concreto_dt_existente_symbol.dart';
import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/shapes/electric_shapes/postes/poste_concreto_dt_projetado_symbol.dart';
import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/shapes/electric_shapes/postes/poste_fibra_vidro_existente_symbol.dart';
import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/shapes/electric_shapes/postes/poste_fibra_vidro_projetado_symbol.dart';
import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/shapes/electric_shapes/postes/poste_madeira_existente_symbol.dart';
import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/shapes/electric_shapes/transformadores/transformador_existente_symbol.dart';
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
    customWidget: TransformadorExistenteSymbol(),
    desc: 'Existente',
    group: 'Transformadores',
    icon: TransformadorExistenteSymbol(size: 24)
  ),
  transformadorProjetado(
    customWidget: TransformadorProjetadoSymbol(),
    desc: 'Projetado',
    group: 'Transformadores',
    icon: TransformadorProjetadoSymbol(size: 24)
  ),
  posteConcretoDtExistente(
    customWidget: PosteConcretoDtExistenteSymbol(),
    desc: 'Concreto DT Existente',
    group: 'Postes',
    icon: PosteConcretoDtExistenteSymbol(size: 24)
  ),
  posteConcretoDtProjetado(
    customWidget: PosteConcretoDtProjetadoSymbol(),
    desc: 'Concreto DT Projetado',
    group: 'Postes',
    icon: PosteConcretoDtProjetadoSymbol(size: 24)
  ),
  posteConcretoCircularExistente(
    customWidget: PosteConcretoCircularExistenteSymbol(),
    desc: 'Concreto Circular Existente',
    group: 'Postes',
    icon: PosteConcretoCircularExistenteSymbol(size: 24)
  ),
  posteConcretoCircularProjetado(
    customWidget: PosteConcretoCircularProjetadoSymbol(),
    desc: 'Concreto Circular Projetado',
    group: 'Postes',
    icon: PosteConcretoCircularProjetadoSymbol(size: 24)
  ),
  posteFibraVidroProjetado(
    customWidget: PosteFibraVidroProjetadoSymbol(),
    desc: 'Fibra de Vidro Projetado',
    group: 'Postes',
    icon: PosteFibraVidroProjetadoSymbol(size: 24)
  ),
  posteFibraVidroExistente(
    customWidget: PosteFibraVidroExistenteSymbol(),
    desc: 'Fibra de Vidro Existente',
    group: 'Postes',
    icon: PosteFibraVidroExistenteSymbol(size: 24)
  ),
  posteMadeiraExistente(
    customWidget: PosteMadeiraExistenteSymbol(),
    desc: 'Madeira Existente',
    group: 'Postes',
    icon: PosteMadeiraExistenteSymbol(size: 24)
  ),
  aterramentoProjetado(
    customWidget: AterramentoProjetadoSymbol(),
    desc: 'Projetado',
    group: 'Aterramentos',
    icon: AterramentoProjetadoSymbol(size: 24)
  ),
  aterramentoExistente(
    customWidget: AterramentoExistenteSymbol(),
    desc: 'Existente',
    group: 'Aterramentos',
    icon: AterramentoExistenteSymbol(size: 24)
  ),
  paraRaiosProjetado(
    customWidget: ParaRaiosProjetadoSymbol(),
    desc: 'Projetado',
    group: 'Para Raios',
    icon: ParaRaiosProjetadoSymbol(size: 24)
  ),
  paraRaiosExistente(
    customWidget: ParaRaiosExistenteSymbol(),
    desc: 'Existente',
    group: 'Para Raios',
    icon: ParaRaiosExistenteSymbol(size: 24)
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

  String get layerTitle => '$group - $desc';

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
