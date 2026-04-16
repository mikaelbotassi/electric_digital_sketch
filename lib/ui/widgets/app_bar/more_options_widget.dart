import 'package:electric_digital_sketch/pages/result_page.dart';
import 'package:flutter/material.dart';
import 'package:simple_painter/simple_painter.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

class MoreOptionsWidget extends StatelessWidget {

  const MoreOptionsWidget({required this.controller, super.key});

  final PainterController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: () async {
          final image = await controller.renderImage();
          if (image != null && context.mounted) {
            await Navigator.push(
              context,
              MaterialPageRoute<dynamic>(
                builder: (context) => ResultPage(image: image),
              ),
            );
          }
        },
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue,
          ),
          child: const Icon(
            TablerIcons.photo,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
