import 'package:electric_digital_sketch/ui/widgets/core/toggle_button/toggle_button.dart';
import 'package:flutter/material.dart';

class ToogleButtonOption<T>{

  const ToogleButtonOption({
    required this.value,
    this.icon,
    this.text,
  });

  final IconData? icon;
  final String? text;
  final T value;

}

class ToggleButtonGroup<T> extends StatefulWidget {

  const ToggleButtonGroup({
    required this.onChanged,
    required this.options,
    this.initialValue,
    super.key
  });

  final List<ToogleButtonOption<T>> options;
  final T? initialValue;
  final ValueChanged<T> onChanged;

  @override
  State<ToggleButtonGroup<T>> createState() => _ToggleButtonGroupState<T>();
}

class _ToggleButtonGroupState<T> extends State<ToggleButtonGroup<T>> {

  late T? _value;

  @override
  void initState() {
    _value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        border: BorderDirectional(
          top: BorderSide(color: colors.primary),
          bottom: BorderSide(color: colors.primary),
          start: BorderSide(color: colors.primary),
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: buttons,
      ),
    );
  }

  List<ToggleButton> get buttons => widget.options.map((o) =>
    ToggleButton(
      onPressed: (){
        setState(() {
          _value = o.value;
        });
        widget.onChanged(o.value);
      },
      active: _value == o.value,
      icon: o.icon,
      text: o.text,
      key: Key('${o.value} - ${o.text}'),
    )).toList();

}
