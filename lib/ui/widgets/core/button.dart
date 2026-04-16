import 'package:flutter/material.dart';

class Button extends StatelessWidget {

  const Button({
    required this.icon,
    this.enabled = true,
    this.onPressed,
    super.key
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(5, 10, 5, 6),
            decoration: BoxDecoration(
              color: enabled ? const Color(0xFF2580eb) : null,
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: Icon(
                icon,
                color: enabled ? Colors.white : Colors.grey.shade500,
              ),
              onPressed: onPressed,
            ),
          ),
          Opacity(
            opacity: enabled ? 1 : 0,
            child: Container(
              height: 2,
              width: 10,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
