import 'dart:math';

import 'package:flutter/material.dart';

class Palette {
  Palette._();
  static const Color primaryColor = Color(0xFF2B63CF);
  static const Color primaryColorDark = Color(0xFF8F90A6);
  static const Color jacarta = Color(0xFF333456);
  static const Color textLight = Color(0xFF888888);
  static const Color buttonColor = Color(0xFF2B63CF);
  static const Color lightBgColor = Color(0xFFF5F5F7);
  static const Color lotion = Color(0xFFFAFAFA);
  static const Color americanSilver = Color(0xFFD1D1D1);
  static const Color secondaryColor = Color(0xFF72738E);
  static const Color secondaryColor2 = Color(0xFF72738E);

  static const Color middleBlue = Color(0xFFE1E1E1);
  static const Color crayola = Color(0xFFA6A7C6);
  static const Color darkBg = Color(0xFFDADBE7);
  static const Color platinum = Color(0xFFE5E5E5);
  static const Color textColor = Color(0xFF444444);
  static const Color lightBlueBg = Color(0xFFF0F9FF);
  static const Color e3e6ff = Color(0xFFE3E6FF);
  static const Color col7166F9 = Color(0xFF7166F9);
  static const Color borderColor = Color(0xffD7D7D7);
  // static const Color  = Color(0xFF);

  static List<Color> colorsList = [
    const Color(0xFF948BFF),
    const Color(0xFFFF7854),
    const Color(0xFFFEA725),
    const Color(0xFF43D9A3),
  ];
  static Color get randomColor {
    final randomNum = Random().nextInt(4);
    return colorsList[randomNum];
  }

  static const Color defaultColorForIcon = Color(0xFFFFB531);
}
