import 'package:flutter/material.dart';

enum ColorBlindnessType {
  none,
  protanopia, // Example type, add others as needed
  deuteranopia,
  tritanopia
}

class ColorProfileProvider with ChangeNotifier {
  ColorBlindnessType _currentType = ColorBlindnessType.none;

  ColorBlindnessType get currentType => _currentType;

  void setColorBlindMode(ColorBlindnessType type) {
    _currentType = type;
    notifyListeners();
  }
}
