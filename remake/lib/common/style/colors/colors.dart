import 'dart:math';
import 'package:flutter/material.dart';

class ColorsApp {
  static Color kPrimary = const Color(0xFF2D63E9);
  static Color white = const Color(0xFFFFFFFF);
  static Color dark = const Color(0xFF000000);
  static Color body = const Color(0xFFF1F2F4);
  static List<Color> random(int count) {
    Random random = Random();
    return List.generate(count, (index) {
      return Color((random.nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0);
    });
  }
}
