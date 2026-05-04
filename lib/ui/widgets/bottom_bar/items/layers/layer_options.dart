import 'package:electric_digital_sketch/ui/viewmodels/electric_sketch_controller.dart';
import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/layers/layer_option_item.dart';
import 'package:flutter/material.dart';

class LayerOptions extends StatelessWidget {
  const LayerOptions({
    required this.controller,
    required this.closeLayers,
    super.key,
  });
  final ElectricSketchController controller;
  final void Function() closeLayers;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ValueListenableBuilder(
        valueListenable: controller.painterController,
        builder: (context, value, child){
          if(value.items.isEmpty){
            return Center(child: Text(
              'SEM CAMADAS',
              style: textTheme.titleLarge,
            ));
          }
          return SizedBox(
            height: 180,
            child: ListView.builder(
              itemCount: value.items.length,
              itemBuilder: (context, index) {
                return LayerOptionItem(
                  controller: controller.painterController,
                  item: value.items[index],
                );
              },
            ),
          );
        }
      ),
    );
  }
}
