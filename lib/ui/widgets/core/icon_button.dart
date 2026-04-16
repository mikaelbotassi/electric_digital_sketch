import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {

  const IconButtonWidget({
    this.icon,
    this.enabled = true,
    this.onPressed,
    this.text,
    this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    super.key
  });

  final IconData? icon;
  final VoidCallback? onPressed;
  final bool enabled;
  final String? text;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final (colors, textTheme) = (Theme.of(context).colorScheme,
    Theme.of(context).textTheme);
    return InkWell(
      onTap: enabled ? onPressed : null,
      child: Padding(
        padding: padding,
        child: Row(
          spacing: 8,
          children: [
            if(icon != null)
              Icon(
                icon,
                color: enabled ? Colors.white : Colors.grey,
              ),
            if(text != null)
              Text(
                text!,
                style: textTheme.bodyMedium?.apply(color:
                enabled ? Colors.white : Colors.grey),
              ),
          ],
        ),
      ),
    );
  }
}
