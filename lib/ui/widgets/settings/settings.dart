import 'dart:typed_data';

import 'package:electric_digital_sketch/ui/viewmodels/electric_sketch_controller.dart';
import 'package:electric_digital_sketch/ui/widgets/settings/custom_widget.dart';
import 'package:electric_digital_sketch/widgets/select_image.dart';
import 'package:flutter/material.dart';
import 'package:electric_digital_sketch/widgets/settings/layers.dart';
import 'package:electric_digital_sketch/widgets/settings/shapes.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Settings extends StatelessWidget {
  const Settings({
    required this.controller,
    super.key,
  });
  final ElectricSketchController controller;
  @override
  Widget build(BuildContext context) {
    Widget settings() {
      Widget buttons(IconData icon, String text, void Function() onTap) {
        return GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 5, 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Colors.grey,
                  size: 30,
                ),
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        );
      }

      return SizedBox(
        height: 90,
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            buttons(PhosphorIconsRegular.stack, 'Layers',
                controller.toggleLayers),
            buttons(PhosphorIconsRegular.polygon, 'Shapes',
                controller.toggleShapes),
            buttons(PhosphorIconsRegular.image, 'Background', () async {
              final imageUint8List = await showDialog<Uint8List>(
                context: context,
                builder: (context) => const SelectImageDialog(
                  title: 'Add Background Image',
                ),
              );
              if (imageUint8List == null) return;
              await controller.setBackgroundImage(imageUint8List);
            }),
            buttons(PhosphorIconsRegular.cubeTransparent, 'Custom Widget',
                () async {
              controller.addCustomWidget(const CustomWidget());
            }),
          ],
        ),
      );
    }

    var height = 0.0;
    if (controller.settingsIsOpen) {
      height = 90;
    }
    if (controller.layersIsOpen) {
      height = 170;
    }
    if (controller.shapesIsOpen) {
      height = 130;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 700),
      curve: Curves.fastLinearToSlowEaseIn,
      height: height,
      child: ClipRect(
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF232323),
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.shade800,
              ),
            ),
          ),
          child: SingleChildScrollView(
            child: controller.layersIsOpen
                ? Layers(
                    controller: controller.painterController,
                    closeLayers: controller.toggleLayers,
                  )
                : controller.shapesIsOpen
                    ? Shapes(
                        controller: controller.painterController,
                        closeShapes: controller.toggleShapes,
                      )
                    : settings(),
          ),
        ),
      ),
    );
  }
}
