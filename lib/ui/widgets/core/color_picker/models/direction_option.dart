import 'package:flutter/material.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

enum GradientDirectionOption {
  back(TablerIcons.arrowLeft, Alignment.centerRight, Alignment.centerLeft),
  forward(TablerIcons.arrowRight, Alignment.centerLeft, Alignment.centerRight),
  upward(TablerIcons.arrowUp, Alignment.bottomCenter, Alignment.topCenter),
  downward(TablerIcons.arrowDown, Alignment.topCenter, Alignment.bottomCenter),
  northEast(TablerIcons.arrowUpRight, Alignment.bottomLeft, Alignment.topRight),
  northWest(TablerIcons.arrowUpLeft, Alignment.bottomRight, Alignment.topLeft),
  southEast(TablerIcons.arrowDownRight,Alignment.topLeft,Alignment.bottomRight),
  southWest(TablerIcons.arrowDownLeft,Alignment.topRight,Alignment.bottomLeft);

  const GradientDirectionOption(this.icon, this.begin, this.end);

  final IconData icon;
  final Alignment begin;
  final Alignment end;
}
