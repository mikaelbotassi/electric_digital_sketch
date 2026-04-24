import 'dart:async';

import 'package:electric_digital_sketch/helpers/listener_service.dart';
import 'package:electric_digital_sketch/ui/viewmodels/electric_sketch_controller.dart';
import 'package:electric_digital_sketch/ui/widgets/app_bar/app_bar_widget.dart';
import 'package:electric_digital_sketch/ui/widgets/bottom_bar/bottom_bar_widget.dart';
import 'package:electric_digital_sketch/ui/widgets/toolbar/toolbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:simple_painter/simple_painter.dart';

class ElectricSketchPage extends StatefulWidget {

  const ElectricSketchPage({super.key});

  @override
  State<ElectricSketchPage> createState() => _ElectricSketchPageState();
}

class _ElectricSketchPageState extends State<ElectricSketchPage> {

  final controller = ElectricSketchController();

  @override
  void initState() {
    super.initState();
    unawaited(ListenerService().listen(controller.painterController, context));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBarWidget(controller: controller),
        bottomNavigationBar: BottomBarWidget(controller: controller),
        body: Stack(
          children: [
            SizedBox(
              height: height,
              child: PainterWidget(controller: controller.painterController),
            ),
            Positioned(
              top: 12,
              left: 12,
              child: ToolbarWidget(controller: controller)
            ),
          ],
        ),
      ),
    );
  }
}
