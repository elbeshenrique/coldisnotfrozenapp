// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ar_conditioner_store.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $AirConditionerStore = BindInject(
  (i) => AirConditionerStore(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AirConditionerStore on _AirConditionerStoreBase, Store {
  Computed<bool> _$isLoadedComputed;

  @override
  bool get isLoaded =>
      (_$isLoadedComputed ??= Computed<bool>(() => super.isLoaded,
              name: '_AirConditionerStoreBase.isLoaded'))
          .value;

  final _$airConditionerConfigurationListAtom =
      Atom(name: '_AirConditionerStoreBase.airConditionerConfigurationList');

  @override
  ObservableList<AirConditionerItemModel> get airConditionerConfigurationList {
    _$airConditionerConfigurationListAtom.reportRead();
    return super.airConditionerConfigurationList;
  }

  @override
  set airConditionerConfigurationList(
      ObservableList<AirConditionerItemModel> value) {
    _$airConditionerConfigurationListAtom
        .reportWrite(value, super.airConditionerConfigurationList, () {
      super.airConditionerConfigurationList = value;
    });
  }

  final _$getDataAsyncAction = AsyncAction('_AirConditionerStoreBase.getData');

  @override
  Future<void> getData() {
    return _$getDataAsyncAction.run(() => super.getData());
  }

  final _$_AirConditionerStoreBaseActionController =
      ActionController(name: '_AirConditionerStoreBase');

  @override
  void setAirConditionerConfigurationList(List<AirConditionerItemModel> value) {
    final _$actionInfo = _$_AirConditionerStoreBaseActionController.startAction(
        name: '_AirConditionerStoreBase.setAirConditionerConfigurationList');
    try {
      return super.setAirConditionerConfigurationList(value);
    } finally {
      _$_AirConditionerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
airConditionerConfigurationList: ${airConditionerConfigurationList},
isLoaded: ${isLoaded}
    ''';
  }
}
