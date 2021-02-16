import 'package:flutter/material.dart';

class ThemeDataConfiguration {
  static ThemeDataConfiguration _instance;
  static ThemeDataConfiguration get instance {
    if (_instance == null) {
      _instance = ThemeDataConfiguration._();
    }

    return _instance;
  }

  ThemeDataConfiguration._();

  ThemeData getLightTheme() {
    var themeData = ThemeData(
      primarySwatch: Colors.blue,
      brightness: Brightness.light,
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

  ThemeData getDarkTheme() {
    var themeData = ThemeData(
      primarySwatch: Colors.blue,
      brightness: Brightness.dark,
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
