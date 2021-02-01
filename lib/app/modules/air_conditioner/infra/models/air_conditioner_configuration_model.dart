import 'package:dart_json_mapper/dart_json_mapper.dart' show jsonSerializable;
import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_configuration.dart';

@jsonSerializable
class AirConditionerConfigurationModel extends AirConditionerConfiguration {
  final String id;
  final double offset;
  final num setpoint;
  final bool isOn;
  final bool useRemote;

  const AirConditionerConfigurationModel({
    this.id,
    this.offset,
    this.setpoint,
    this.isOn,
    this.useRemote,
  });
}
