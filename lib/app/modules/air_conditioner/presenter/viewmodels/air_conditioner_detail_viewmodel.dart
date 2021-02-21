import 'package:mobx/mobx.dart';

part 'air_conditioner_detail_viewmodel.g.dart';

class AirConditionerDetailViewModel = _AirConditionerDetailViewModelBase with _$AirConditionerDetailViewModel;

abstract class _AirConditionerDetailViewModelBase with Store {
  @observable
  String id;
  @action
  changeId(String value) => id = value;

  @observable
  double offset;
  @action
  changeOffset(double value) => offset = value;

  @observable
  double setpoint;
  @action
  changeSetpoint(double value) => setpoint = value;

  @observable
  bool isOn;
  @action
  changeIsOn(bool value) => isOn = value;

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
