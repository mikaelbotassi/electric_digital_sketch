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

  static GradientDirectionOption fromBeginAndEnd(
    Alignment begin,
    Alignment end,
  ) {
    return switch ((begin, end)) {
      (Alignment.centerRight, Alignment.centerLeft) => back,
      (Alignment.bottomCenter, Alignment.topCenter) => upward,
      (Alignment.topCenter, Alignment.bottomCenter) => downward,
      (Alignment.bottomLeft, Alignment.topRight) => northEast,
      (Alignment.bottomRight, Alignment.topLeft) => northWest,
      (Alignment.topLeft, Alignment.bottomRight) => southEast,
      (Alignment.topRight, Alignment.bottomLeft) => southWest,
      _ => forward,
    };
  }

}
