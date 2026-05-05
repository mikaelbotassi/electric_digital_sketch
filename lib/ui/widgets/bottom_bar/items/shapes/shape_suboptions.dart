import 'package:electric_digital_sketch/domain/enums/electric_shape_type.dart';
import 'package:electric_digital_sketch/ui/widgets/core/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:simple_painter/simple_painter.dart';

class ShapeSubOptions extends StatelessWidget {
  const ShapeSubOptions({
    required this.shapes,
    required this.controller,
    super.key,
  });
  final PainterController controller;
  final List<ElectricShapeType> shapes;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          spacing: 8,
          children: shapes.map((shape) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButtonWidget(
                onPressed: (){
                  if(shape.type != null){
                    controller.addShape(shape.type!);
                    return;
                  }
                  if(shape.customWidget != null){
                    controller.addCustomWidget(shape.customWidget!);
                    return;
                  }
                  controller.addCustomWidget(shape.icon);
                },
                child: shape.icon
              ),
              Text(shape.desc, style: textTheme.labelMedium)
            ],
          )).toList(growable: false)
      ),
    );
  }
}
