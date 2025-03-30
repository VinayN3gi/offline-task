// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

Color strenghtenColor(Color color, double factor) {
  int r = (color.red * factor).clamp(0, 255).toInt();
  int b = (color.blue * factor).clamp(0, 255).toInt();
  int g = (color.green * factor).clamp(0, 255).toInt();

  return Color.fromARGB(color.alpha, r, g, b);
}
