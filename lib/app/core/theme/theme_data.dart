import 'package:flutter/material.dart';

class ThemeDataConfiguration {
  static getThemeData(BuildContext context) {
    var themeData = ThemeData(
      primarySwatch: Colors.blue,
    );

    themeData = themeData.copyWith(
      buttonTheme: themeData.buttonTheme.copyWith(
        colorScheme: themeData.colorScheme.copyWith(
          secondary: Colors.white,
        ),
      ),
    );

    return themeData;
  }
}
