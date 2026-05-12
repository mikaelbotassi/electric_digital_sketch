import 'package:flutter/cupertino.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

/// Interaction modes available in the editor toolbar.
enum SketchMode {
  select('Seleção', TablerIcons.handClick),
  brush('Pincel', TablerIcons.brush),
  erase('Borracha', TablerIcons.eraser),
  changes('Alterações', TablerIcons.listNumbers),
  text('Texto', TablerIcons.textRecognition),
  shapes('Formas', TablerIcons.shape),
  layers('Camadas', TablerIcons.stackFront),
  redes('Redes', TablerIcons.line)
  ;

  const SketchMode(this.title, this.icon);

  /// Icon shown for the mode.
  final IconData icon;

  /// Human-readable title used by the UI.
  final String title;
}
