import 'dart:io';

import 'package:electric_digital_sketch/pages/add_edit_text_page.dart';
import 'package:electric_digital_sketch/ui/viewmodels/electric_sketch_controller.dart';
import 'package:electric_digital_sketch/ui/widgets/core/button.dart';
import 'package:flutter/material.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

class BottomBarWidget extends StatelessWidget {

  const BottomBarWidget({
    required this.controller,
    super.key
  });

  final ElectricSketchController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF232323),
      padding: EdgeInsets.only(
        bottom: Platform.isIOS ? 20 : 10,
      ),
      child: SafeArea(
        top: false,
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Button(
                icon: TablerIcons.eraser,
                onPressed: controller.toggleErasing,
                enabled: controller.isErasing,
              ),
              Button(
                icon: TablerIcons.scribble,
                onPressed: controller.toggleDrawing,
                enabled: controller.isDrawing,
              ),
              Button(
                icon: TablerIcons.textRecognition,
                onPressed: () async {
                  var text = '';
                  await Navigator.push(
                    context,
                    PageRouteBuilder<Object>(
                      opaque: false,
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          AddEditTextPage(onDone: (textFunction) {
                            text = textFunction;
                          }),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                          FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                    ),
                  );
                  await controller.addText(text);
                },
                enabled: controller.editingText || controller.addingText,
              ),
              Button(
                icon: TablerIcons.list,
                onPressed: controller.toggleSettings,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
