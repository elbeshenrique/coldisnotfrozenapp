import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'localization_store.g.dart';

class LocalizationStore = _LocalizationStoreBase with _$LocalizationStore;

abstract class _LocalizationStoreBase with Store {
  @observable
  Locale deviceLocale = Locale('en', 'US');

  @action
  void setDeviceLocale(Locale value) => deviceLocale = value;
}
