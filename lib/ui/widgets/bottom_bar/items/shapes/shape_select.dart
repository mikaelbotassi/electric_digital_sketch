import 'package:electric_digital_sketch/domain/enums/electric_shape_type.dart';
import 'package:electric_digital_sketch/ui/widgets/bottom_bar/items/shapes/shape_subselect.dart';
import 'package:electric_digital_sketch/ui/widgets/core/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:simple_painter/simple_painter.dart';

class ShapeSelect extends StatefulWidget {
  const ShapeSelect({
    required this.controller,
    super.key,
  });
  final PainterController controller;

  @override
  State<ShapeSelect> createState() => _ShapeSelectState();
}

class _ShapeSelectState extends State<ShapeSelect> {

  String _selectedGroup = 'Geral';

  @override
  Widget build(BuildContext context) {
    final groups = ElectricShapeType.groups.entries;
    final theme = Theme.of(context);
    final (textTheme,colors) = (theme.textTheme, theme.colorScheme);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ShapeSubSelect(
            controller: widget.controller,
            shapes: ElectricShapeType.findByGroup(_selectedGroup),
          ),
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: colors.onSurface.withAlpha(10),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                spacing: 8,
                children: groups.map((e) => Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _selectedGroup == e.key ?
                      colors.onSurface.withAlpha(10) : null,
                    border: Border.all(color: _selectedGroup == e.key ?
                      colors.onSurface.withAlpha(50) : Colors.transparent),
                    borderRadius: BorderRadius.circular(4)
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButtonWidget(
                        onPressed: (){
                          setState(() {
                            _selectedGroup = e.key;
                          });
                        },
                        child: e.value.first.icon
                      ),
                      Text(e.key, style: textTheme.labelMedium)
                    ],
                  ),
                )).toList(growable: false)
            ),
          ),
        ),
      ],
    );
  }
}
