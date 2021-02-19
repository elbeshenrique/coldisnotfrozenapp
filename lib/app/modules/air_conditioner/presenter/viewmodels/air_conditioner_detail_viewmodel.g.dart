// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'air_conditioner_detail_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AirConditionerDetailViewModel
    on _AirConditionerDetailViewModelBase, Store {
  final _$idAtom = Atom(name: '_AirConditionerDetailViewModelBase.id');

  @override
  String get id {
    _$idAtom.reportRead();
    return super.id;
  }

  @override
  set id(String value) {
    _$idAtom.reportWrite(value, super.id, () {
      super.id = value;
    });
  }

  final _$offsetAtom = Atom(name: '_AirConditionerDetailViewModelBase.offset');

  @override
  num get offset {
    _$offsetAtom.reportRead();
    return super.offset;
  }

  @override
  set offset(num value) {
    _$offsetAtom.reportWrite(value, super.offset, () {
      super.offset = value;
    });
  }

  final _$setpointAtom =
      Atom(name: '_AirConditionerDetailViewModelBase.setpoint');

  @override
  num get setpoint {
    _$setpointAtom.reportRead();
    return super.setpoint;
  }

  @override
  set setpoint(num value) {
    _$setpointAtom.reportWrite(value, super.setpoint, () {
      super.setpoint = value;
    });
  }

  final _$isOnAtom = Atom(name: '_AirConditionerDetailViewModelBase.isOn');

  @override
  bool get isOn {
    _$isOnAtom.reportRead();
    return super.isOn;
  }

  @override
  set isOn(bool value) {
    _$isOnAtom.reportWrite(value, super.isOn, () {
      super.isOn = value;
    });
  }

  final _$useRemoteAtom =
      Atom(name: '_AirConditionerDetailViewModelBase.useRemote');

  @override
  bool get useRemote {
    _$useRemoteAtom.reportRead();
    return super.useRemote;
  }

  @override
  set useRemote(bool value) {
    _$useRemoteAtom.reportWrite(value, super.useRemote, () {
      super.useRemote = value;
    });
  }

  final _$_AirConditionerDetailViewModelBaseActionController =
      ActionController(name: '_AirConditionerDetailViewModelBase');

  @override
  dynamic changeId(String value) {
    final _$actionInfo = _$_AirConditionerDetailViewModelBaseActionController
        .startAction(name: '_AirConditionerDetailViewModelBase.changeId');
    try {
      return super.changeId(value);
    } finally {
      _$_AirConditionerDetailViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeOffset(num value) {
    final _$actionInfo = _$_AirConditionerDetailViewModelBaseActionController
        .startAction(name: '_AirConditionerDetailViewModelBase.changeOffset');
    try {
      return super.changeOffset(value);
    } finally {
      _$_AirConditionerDetailViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeSetpoint(num value) {
    final _$actionInfo = _$_AirConditionerDetailViewModelBaseActionController
        .startAction(name: '_AirConditionerDetailViewModelBase.changeSetpoint');
    try {
      return super.changeSetpoint(value);
    } finally {
      _$_AirConditionerDetailViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeIsOn(bool value) {
    final _$actionInfo = _$_AirConditionerDetailViewModelBaseActionController
        .startAction(name: '_AirConditionerDetailViewModelBase.changeIsOn');
    try {
      return super.changeIsOn(value);
    } finally {
      _$_AirConditionerDetailViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeUseRemote(bool value) {
    final _$actionInfo =
        _$_AirConditionerDetailViewModelBaseActionController.startAction(
            name: '_AirConditionerDetailViewModelBase.changeUseRemote');
    try {
      return super.changeUseRemote(value);
    } finally {
      _$_AirConditionerDetailViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
id: ${id},
offset: ${offset},
setpoint: ${setpoint},
isOn: ${isOn},
useRemote: ${useRemote}
    ''';
  }
}
