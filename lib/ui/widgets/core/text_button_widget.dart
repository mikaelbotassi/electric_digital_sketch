import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {

  const TextButtonWidget({
    this.icon,
    this.text,
    this.enabled = true,
    this.onPressed,
    super.key
  });

  final IconData? icon;
  final String? text;
  final VoidCallback? onPressed;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final iconSize = text != null ? 16.0 : 24.0;
    return InkWell(
      onTap: enabled ? onPressed : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          spacing: 8,
          children: [
            if(icon != null) Icon(icon, color: Colors.white, size: iconSize),
            if(text != null) Text(
              text!,
                style: textTheme.bodyMedium?.apply(color: Colors.white)
              )
          ],
        ),
      ),
    );
  }
}
