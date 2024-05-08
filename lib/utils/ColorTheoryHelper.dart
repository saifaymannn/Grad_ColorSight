import 'package:flutter/material.dart';

class ColorTheoryHelper {
  static bool areColorsComplementary(Color color1, Color color2) {
    HSLColor hslColor1 = HSLColor.fromColor(color1);
    HSLColor hslColor2 = HSLColor.fromColor(color2);
    double angle = (hslColor1.hue - hslColor2.hue).abs();
    return angle > 150 && angle < 210;  // Complementary colors are approximately 180 degrees apart in the HSL color wheel.
  }
}
