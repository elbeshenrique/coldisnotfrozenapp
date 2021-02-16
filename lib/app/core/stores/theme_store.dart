import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'theme_store.g.dart';

@Injectable()
class ThemeStore = _ThemeStoreBase with _$ThemeStore;

abstract class _ThemeStoreBase with Store {
  _ThemeStoreBase();

  @observable
  Brightness brightness = WidgetsBinding.instance.window.platformBrightness;

  @action
  void setBrightness(Brightness value) => brightness = value;
}
