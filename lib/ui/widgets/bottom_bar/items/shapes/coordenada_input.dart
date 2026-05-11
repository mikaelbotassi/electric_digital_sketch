import 'package:electric_digital_sketch/plugins/location_service.dart';
import 'package:electric_digital_sketch/ui/widgets/core/borderless_input.dart';
import 'package:electric_digital_sketch/ui/widgets/core/icon_button.dart';
import 'package:electric_shapes/electric_shapes.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CoordenadaInput extends StatefulWidget {

  const CoordenadaInput({
    required this.onChanged,
    required this.initialValue,
    super.key
  });

  final LatLong? initialValue;
  final ValueChanged<LatLong?> onChanged;

  @override
  State<CoordenadaInput> createState() => _CoordenadaInputState();
}

class _CoordenadaInputState extends State<CoordenadaInput> {

  late final TextEditingController latControl;
  late final TextEditingController longControl;

  void _notifyChanged() {
    final latitude = double.tryParse(latControl.text);
    final longitude = double.tryParse(longControl.text);

    if (latitude == null || longitude == null) {
      widget.onChanged(null);
      return;
    }

    widget.onChanged(LatLong(latitude, longitude));
  }

  void clear(){
    latControl.text = '';
    longControl.text = '';
    _notifyChanged();
  }

  @override
  void initState() {
    final initialValue = widget.initialValue;
    latControl = TextEditingController(text:
      (initialValue?.latitude ?? '').toString());
    longControl = TextEditingController(text: (initialValue?.longitude ?? '')
      .toString());
    super.initState();
  }

  @override
  void dispose() {
    latControl.dispose();
    longControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: .start,
      spacing: 8,
      children: [
        const Text('Coordenadas'),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: colors.outline.withAlpha(100)),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            spacing: 8,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  border: BorderDirectional(
                    end: BorderSide(color: colors.outline.withAlpha(100))
                  ),
                ),
                child: IconButtonWidget(
                  color: colors.primary,
                  icon: PhosphorIconsRegular.mapPin,
                  onPressed: () async {
                    final pos = await LocationService.getCurrentPosition();
                    latControl.text = pos?.latitude.toString() ?? '';
                    longControl.text = pos?.longitude.toString() ?? '';
                    return widget.onChanged(pos);
                  },
                ),
              ),
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: BorderDirectional(
                      end: BorderSide(color: colors.outline.withAlpha(100))
                    ),
                  ),
                  child: BorderlessInput(
                    controller: latControl,
                    onChanged: (_) => _notifyChanged(),
                    label: 'Latitude',
                  ),
                ),
              ),
              const VerticalDivider(),
              Expanded(
                child: BorderlessInput(
                  controller: longControl,
                  onChanged: (_) => _notifyChanged(),
                  label: 'Longitude',
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  border: BorderDirectional(
                    start: BorderSide(color: colors.outline.withAlpha(100))
                  ),
                ),
                child:IconButtonWidget(
                  icon: PhosphorIconsRegular.x,
                  color: colors.outline.withAlpha(100),
                  onPressed: clear,
                ))
            ],
          ),
        ),
      ],
    );
  }
}
