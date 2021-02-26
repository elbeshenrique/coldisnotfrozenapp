// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ar_conditioner_detail_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AirConditionerDetailController
    on _AirConditionerDetailControllerBase, Store {
  final _$stateAtom = Atom(name: '_AirConditionerDetailControllerBase.state');

  @override
  AirConditionerDetailState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(AirConditionerDetailState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$_AirConditionerDetailControllerBaseActionController =
      ActionController(name: '_AirConditionerDetailControllerBase');

  @override
  dynamic setState(AirConditionerDetailState value) {
    final _$actionInfo = _$_AirConditionerDetailControllerBaseActionController
        .startAction(name: '_AirConditionerDetailControllerBase.setState');
    try {
      return super.setState(value);
    } finally {
      _$_AirConditionerDetailControllerBaseActionController
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
