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

  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch as Map<int, Color>);
  }

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

/// Random Colors Generator
///
/// Usage
/// ```dart
/// RandomColors generator = RandomColors({Colors.red, Colors.blue});
/// List<Color> colors = List.generate(10, (_) => generator.nextColor);
/// ```
///
class RandomColors {
  Random random;
  Set<Color> colors;
  int? prevIndexLight;

  /// Default constructor
  ///
  /// Pass in an optional int [seed] which will be used to instantiate the [Random] instance
  RandomColors(this.colors, [int? seed]) : random = Random(seed);

  /// Used for generating random colors
  ///
  /// This will automatically ensure that you will never receive
  /// the same color from successive calls to [nextColor]
  Color get nextColor {
    int length = colors.length;
    int newIndex = random.nextInt(length);

    if (prevIndexLight == null || prevIndexLight != newIndex) {
      prevIndexLight = newIndex;
    } else {
      prevIndexLight = newIndex = (newIndex + 1) % length;
    }

    return colors.elementAt(newIndex);
  }
}

extension ColorExtension on Color {
  Color get darken {
    return Color.fromRGBO((red * 0.85).toInt(), (green * 0.85).toInt(),
        (blue * 0.85).toInt(), opacity);
  }

  String get toHex {
    return '#${(value & 0xFFFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';
  }
}

extension HexColor on String {
  Color get colorFromHex {
    try {
      var hexColor = toUpperCase().replaceAll("#", "");
      if (hexColor.length == 6) {
        hexColor = "FF$hexColor";
      }
      return Color(int.parse(hexColor, radix: 16));
    } catch (e) {
      return Colors.black;
    }
  }
}
