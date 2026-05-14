import 'package:flutter/material.dart';
class ActionButton extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;
  final VoidCallback onTap;

  const ActionButton({
    super.key,
    required this.title,
    required this.backgroundColor,
    required this.textColor,
    required this.onTap,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: backgroundColor,
        side: borderColor != null
            ? BorderSide(color: borderColor!)
            : BorderSide.none,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onTap,
      child: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 14,
        ),
      ),
    );
  }
}