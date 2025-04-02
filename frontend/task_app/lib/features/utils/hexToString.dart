// ignore_for_file: deprecated_member_use, file_names

import 'dart:ui';

String rgbToHex(Color color) {
  return '${color.red.toRadixString(16).padLeft(2, '0')}${color.green.toRadixString(16).padLeft(2, '0')}${color.blue.toRadixString(16).padLeft(2, '0')}';
}

Color hexTorgb(String hex) {
  return Color(int.parse(hex, radix: 16)+0xFF000000);
}
