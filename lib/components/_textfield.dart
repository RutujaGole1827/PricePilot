import 'package:flutter/material.dart';
Widget _textField(
    String label, {
      int maxLines = 1,
      IconData? suffixIcon,
      TextEditingController? controller,
    }) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(height: 8),
      TextField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(fontSize: 11),
        decoration: InputDecoration(
          suffixIcon:
          suffixIcon != null ? Icon(suffixIcon, size: 18) : null,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color(0xffD7E1EC),
            ),
          ),
        ),
      ),
    ],
  );
}