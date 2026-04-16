import 'package:flutter/cupertino.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

enum SketchMode {
  select(TablerIcons.handClick, showActive: true),
  erase(TablerIcons.eraser, showActive: true),
  brush(TablerIcons.brush, showActive: true),
  text(TablerIcons.textRecognition),
  shapes(TablerIcons.shape),
  layers(TablerIcons.stackFront);

  const SketchMode(this.icon, {this.showActive = false});

  final IconData icon;
  final bool showActive;


}
