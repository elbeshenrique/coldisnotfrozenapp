// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ar_conditioner_list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AirConditionerListController
    on _AirConditionerListControllerBase, Store {
  final _$stateAtom = Atom(name: '_AirConditionerListControllerBase.state');

  @override
  AirConditionerState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(AirConditionerState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$_AirConditionerListControllerBaseActionController =
      ActionController(name: '_AirConditionerListControllerBase');

  @override
  dynamic setState(AirConditionerState value) {
    final _$actionInfo = _$_AirConditionerListControllerBaseActionController
        .startAction(name: '_AirConditionerListControllerBase.setState');
    try {
      return super.setState(value);
    } finally {
      _$_AirConditionerListControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
