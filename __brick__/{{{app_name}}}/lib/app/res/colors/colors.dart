import 'package:flutter/material.dart';

/// This Class Is Used To Get Colors

class AppColors {

  /// Available colors in whole application
  ///
  ///
  ///
  ///
  static const Color colorPrimary = Color(0xFFFF5BBF);
  static const Color colorSecondary = Color(0xFF01B5BE);
  static const Color colorAccent = Color(0xFFFFFFFF);
  static const Color white = Color(0xFFffffff);
  static const Color colorDarkGrey = Color(0xFF474747);
  static const Color green = Color(0xFF01B5BE);
  static const Color colorLightGrey = Color(0xFF919191);
  static MaterialColor materialColorPrimarySwatch =
  createMaterialColor(colorPrimary);

/*  static const Color lighterGrey = Color(0xFFF9F9F9);
  static const Color colorAvatarGrey = Color(0xFFF0F1F1);
  static const Color colorDark = Color(0xFF000000);
  static const Color cancelTextColor = Color(0XFFA6A6A6);

  static const Color green = Color(0xFF01B5BE);
  static const Color red = Color(0xFFff0000);
  static const Color colorBlack = Color(0xFF000000);
  static const Color dividerLightGrey = Color(0xFFEFEFEF);

  static const Color colorGrey = Color(0xFFA7A7A7);
  static const Color colorDivider = Color(0xFFE8E8E8);
  static MaterialColor materialColorPrimarySwatch =
      createMaterialColor(colorPrimary);*/

  /// Get Material Color From Simple Colors
  static MaterialColor createMaterialColor(Color color) {
    final  strengths = <double>[.05];
    final  swatch = <int, Color>{};
    final  r = color.red;
    final  g = color.green;
    final b = color.blue;

    for (var i = 1; i < 10; i++) {
      strengths.add(i * 0.1);
    }
    for (final strength in strengths) {
      final ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }


}

/// Get Color According To Theme (Dark/Light)
extension ColorExtenstion on BuildContext {
  Color get primaryColor =>  AppColors.colorPrimary;

  Color get secondaryColor =>  AppColors.colorSecondary;

  Color get accentColor =>  AppColors.colorAccent;


  Color get darkGreyColor => AppColors.colorDarkGrey;


  Color get lightGreyColor =>  AppColors.colorLightGrey;

}
