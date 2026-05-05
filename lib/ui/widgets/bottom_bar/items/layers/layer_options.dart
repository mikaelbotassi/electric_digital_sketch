import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/layers/layer_option_item.dart';
import 'package:flutter/material.dart';
import 'package:simple_painter/simple_painter.dart';

class LayerOptions extends StatelessWidget {
  const LayerOptions({
    required this.controller,
    super.key,
  });
  final PainterController controller;
  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ValueListenableBuilder(
        valueListenable: controller,
        builder: (context, value, child){
          if(value.items.isEmpty){
            return Center(child: Text(
              'SEM CAMADAS',
              style: textTheme.titleLarge,
            ));
          }
          return Column(
            spacing: 8,
            children: getItems(value),
          );
        }
      ),
    );
  }

  List<Widget> getItems(PainterControllerValue value) => value.items.map(
    (item) => LayerOptionItem(
      controller: controller,
      item: item,
    )).toList(growable: false);

}
