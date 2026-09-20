import 'package:flutter/material.dart';

/// Google Keep palette — Material 3 friendly tints.
const List<int> keepNoteColors = [
  0xFFFFFFFF, // Default white
  0xFFF28B82, // Red
  0xFFFBBC04, // Orange
  0xFFFFF475, // Yellow
  0xFFCCFF90, // Green
  0xFFA7FFEB, // Teal
  0xFFCBF0F8, // Light blue
  0xFFAECBFA, // Blue
  0xFFD7AEFB, // Purple
  0xFFFDCFE8, // Pink
  0xFFE6C9A8, // Brown
  0xFFE8EAED, // Grey
];

/// Returns a subtle surface tint derived from note color for Material 3 card.
Color noteSurfaceColor(int argb, BuildContext context) {
  final c = Color(argb);
  if (c.toARGB32() == 0xFFFFFFFF) return Theme.of(context).colorScheme.surface;
  return Color.lerp(c, Colors.white, 0.72)!;
}

Color noteBorderColor(int argb) {
  final c = Color(argb);
  if (c.toARGB32() == 0xFFFFFFFF) return const Color(0xFFE0E0E0);
  return Color.lerp(c, Colors.black, 0.12)!;
}
