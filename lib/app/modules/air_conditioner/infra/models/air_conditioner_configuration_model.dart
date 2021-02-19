import 'package:dart_json_mapper/dart_json_mapper.dart' show jsonSerializable;

import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_configuration.dart';

@jsonSerializable
class AirConditionerConfigurationModel implements AirConditionerConfiguration {
  @override
  final String id;
  
  @override
  final bool isOn;
  
  @override
  final double offset;
  
  @override
  final double setpoint;
  
  @override
  final bool useRemote;

  AirConditionerConfigurationModel({
    this.id,
    this.isOn,
    this.offset,
    this.setpoint,
    this.useRemote,
  });
}
