import 'package:electric_shapes/electric_shapes.dart';
import 'package:flutter/material.dart';
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
    customWidget: TransformadorExistenteSymbol(fontSize: 12),
    desc: 'Existente',
    group: 'Transformadores',
    icon: Icon(ElectricIcons.transformadorExistente)
  ),
  transformadorProjetado(
    customWidget: TransformadorProjetadoSymbol(fontSize: 12),
    desc: 'Projetado',
    group: 'Transformadores',
    icon: Icon(ElectricIcons.transformadorProjetado)
  ),
  posteConcretoDtExistente(
    customWidget: PosteConcretoDtExistenteSymbol(fontSize: 12),
    desc: 'Concreto DT Existente',
    group: 'Postes',
    icon: Icon(ElectricIcons.posteConcretoDTExistente)
  ),
  posteConcretoDtProjetado(
    customWidget: PosteConcretoDtProjetadoSymbol(fontSize: 12),
    desc: 'Concreto DT Projetado',
    group: 'Postes',
    icon: Icon(ElectricIcons.posteConcretoDTProjetado)
  ),
  posteConcretoCircularExistente(
    customWidget: PosteConcretoCircularExistenteSymbol(fontSize: 12),
    desc: 'Concreto Circular Existente',
    group: 'Postes',
    icon: Icon(ElectricIcons.posteConcretoCircularExistente)
  ),
  posteConcretoCircularProjetado(
    customWidget: PosteConcretoCircularProjetadoSymbol(fontSize: 12),
    desc: 'Concreto Circular Projetado',
    group: 'Postes',
    icon: Icon(ElectricIcons.posteConcretoCircularProjetado)
  ),
  posteFibraVidroProjetado(
    customWidget: PosteFibraVidroProjetadoSymbol(fontSize: 12),
    desc: 'Fibra de Vidro Projetado',
    group: 'Postes',
    icon: Icon(ElectricIcons.posteFibraVidroProjetado)
  ),
  posteFibraVidroExistente(
    customWidget: PosteFibraVidroExistenteSymbol(fontSize: 12),
    desc: 'Fibra de Vidro Existente',
    group: 'Postes',
    icon: Icon(ElectricIcons.posteFibraVidroExistente)
  ),
  posteMadeiraExistente(
    customWidget: PosteMadeiraExistenteSymbol(fontSize: 12),
    desc: 'Madeira Existente',
    group: 'Postes',
    icon: Icon(ElectricIcons.posteMadeiraExistente)
  ),
  aterramentoProjetado(
    customWidget: AterramentoProjetadoSymbol(fontSize: 12),
    desc: 'Projetado',
    group: 'Aterramentos',
    icon: Icon(ElectricIcons.aterramentoProjetado)
  ),
  aterramentoExistente(
    customWidget: AterramentoExistenteSymbol(fontSize: 12),
    desc: 'Existente',
    group: 'Aterramentos',
    icon: Icon(ElectricIcons.aterramentoExistente)
  ),
  paraRaiosProjetado(
    customWidget: ParaRaiosProjetadoSymbol(fontSize: 12),
    desc: 'Projetado',
    group: 'Para Raios',
    icon: Icon(ElectricIcons.paraRaioProjetado)
  ),
  paraRaiosExistente(
    customWidget: ParaRaiosExistenteSymbol(fontSize: 12),
    desc: 'Existente',
    group: 'Para Raios',
    icon: Icon(ElectricIcons.paraRaioExistente)
  ),
  chaveFacaProjetada(
    customWidget: ChaveFacaProjetadaSymbol(fontSize: 12),
    desc: 'Faca Projetada',
    group: 'Chaves',
    icon: Icon(ElectricIcons.chaveFacaProjetada)
  ),
  chaveFacaExistente(
    customWidget: ChaveFacaExistenteSymbol(fontSize: 12),
    desc: 'Faca Existente',
    group: 'Chaves',
    icon: Icon(ElectricIcons.chaveFacaExistente)
  ),
  chaveFusivelProjetada(
    customWidget: ChaveFusivelProjetadaSymbol(fontSize: 12),
    desc: 'Fusível Projetada',
    group: 'Chaves',
    icon: Icon(ElectricIcons.chaveFusivelProjetada)
  ),
  chaveFusivelExistente(
      customWidget: ChaveFusivelExistenteSymbol(fontSize: 12),
      desc: 'Fusível Existente',
      group: 'Chaves',
      icon: Icon(ElectricIcons.chaveFusivelExistente)
  ),
  chaveReligadoraProjetada(
      customWidget: ChaveReligadoraProjetadaSymbol(fontSize: 12),
      desc: 'Religadora Projetada',
      group: 'Chaves',
      icon: Icon(ElectricIcons.chaveReligadoraProjetada)
  ),
  chaveReligadoraExistente(
      customWidget: ChaveReligadoraExistenteSymbol(fontSize: 12),
      desc: 'Religadora Existente',
      group: 'Chaves',
      icon: Icon(ElectricIcons.chaveReligadoraExistente)
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
