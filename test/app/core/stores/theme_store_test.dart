import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guard_class/app/core/stores/theme_store.dart';

main() {
  final themeStore = ThemeStore();

  group('setBrightness', () {
    test('should set brightness to dark', () {
      themeStore.setBrightness(Brightness.light);
      expect(themeStore.brightness, Brightness.light);
    });
    test('should set brightness to dark', () {
      themeStore.setBrightness(Brightness.dark);
      expect(themeStore.brightness, Brightness.dark);
    });
  });
}
