import 'dart:async';

import 'package:electric_digital_sketch/domain/enums/sketch_mode.dart';
import 'package:electric_digital_sketch/ui/add_edit_text_page.dart';
import 'package:electric_digital_sketch/ui/widgets/toolbar/items/toolbar_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:simple_painter/simple_painter.dart';

class TextToolbarItemWidget extends ToolbarItemWidget {

  const TextToolbarItemWidget({required super.controller, super.key});

  @override
  SketchMode get mode => SketchMode.text;

  @override
  bool get isActive => SketchMode.select == controller.mode;

  @override
  FutureOr<void> onPressed(BuildContext context) async {
    controller.setMode(mode);
    final text = await Navigator.push(context,
      PageRouteBuilder<String>(
        opaque: false,
        pageBuilder: (context, animation, secondaryAnimation) =>
        const AddEditTextPage(),
      ),
    );
    if(text != null && text.isNotEmpty) await painterController.addText(text);
    controller.setMode(SketchMode.select);
  }

}
