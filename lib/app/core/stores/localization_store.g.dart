// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'localization_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LocalizationStore on _LocalizationStoreBase, Store {
  final _$deviceLocaleAtom = Atom(name: '_LocalizationStoreBase.deviceLocale');

  @override
  Locale get deviceLocale {
    _$deviceLocaleAtom.reportRead();
    return super.deviceLocale;
  }

  @override
  set deviceLocale(Locale value) {
    _$deviceLocaleAtom.reportWrite(value, super.deviceLocale, () {
      super.deviceLocale = value;
    });
  }

  final _$_LocalizationStoreBaseActionController =
      ActionController(name: '_LocalizationStoreBase');

  @override
  void setDeviceLocale(Locale value) {
    final _$actionInfo = _$_LocalizationStoreBaseActionController.startAction(
        name: '_LocalizationStoreBase.setDeviceLocale');
    try {
      return super.setDeviceLocale(value);
    } finally {
      _$_LocalizationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
deviceLocale: ${deviceLocale}
    ''';
  }
}
