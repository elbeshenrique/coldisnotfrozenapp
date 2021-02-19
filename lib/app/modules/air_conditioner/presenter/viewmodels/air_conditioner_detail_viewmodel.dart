import 'package:mobx/mobx.dart';

import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_configuration.dart';

part 'air_conditioner_detail_viewmodel.g.dart';

class AirConditionerDetailViewModel = _AirConditionerDetailViewModelBase with _$AirConditionerDetailViewModel;

abstract class _AirConditionerDetailViewModelBase with Store implements AirConditionerConfiguration {
  @override
  @observable
  String id;
  @action
  changeId(String value) => id = value;

  @override
  @observable
  double offset;
  @action
  changeOffset(double value) => offset = value;

  @override
  @observable
  double setpoint;
  @action
  changeSetpoint(double value) => setpoint = value;

  @override
  @observable
  bool isOn;
  @action
  changeIsOn(bool value) => isOn = value;

  @override
  @observable
  bool useRemote;
  @action
  changeUseRemote(bool value) => useRemote = value;

  _AirConditionerDetailViewModelBase({
    this.id,
    this.offset,
    this.setpoint,
    this.isOn,
    this.useRemote,
  });
}
