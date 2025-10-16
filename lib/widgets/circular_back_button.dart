import 'package:flutter/material.dart';

class CircularBackButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const CircularBackButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: IconButton(
        onPressed: onPressed ?? () => Navigator.of(context).pop(),
        icon: const Icon(Icons.chevron_left, color: Colors.black87, size: 24),
        padding: EdgeInsets.zero,
      ),
    );
  }
}
