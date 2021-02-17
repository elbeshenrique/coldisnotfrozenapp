import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_configuration.dart';

class AirConditionerConfigurationViewModel implements AirConditionerConfiguration {
  @override
  String id;

  @override
  num offset;

  @override
  num setpoint;

  @override
  bool isOn;

  @override
  bool useRemote;

  AirConditionerConfigurationViewModel({
    this.id,
    this.offset,
    this.setpoint,
    this.isOn,
    this.useRemote,
  });

  factory AirConditionerConfigurationViewModel.fromBase(AirConditionerConfiguration base) {
    return AirConditionerConfigurationViewModel(
      id: base.id,
      offset: base.offset,
      setpoint: base.setpoint,
      isOn: base.isOn,
      useRemote: base.useRemote,
    );
  }
}
