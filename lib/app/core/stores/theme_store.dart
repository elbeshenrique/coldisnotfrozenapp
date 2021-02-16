import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'theme_store.g.dart';

class ThemeStore = _ThemeStoreBase with _$ThemeStore;

abstract class _ThemeStoreBase with Store {
  @observable
  Brightness brightness = Brightness.light;

  @action
  void setBrightness(Brightness value) => brightness = value;
}
