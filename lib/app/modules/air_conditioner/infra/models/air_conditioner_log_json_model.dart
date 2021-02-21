import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_log_json.dart';

@jsonSerializable
class AirConditionerLogJsonModel implements AirConditionerLogJson {

  @override
  final bool isOn;

  @override
  final num localTemperature;

  @override
  final num offset;

  @override
  final bool relayStatus;

  @override
  final num remoteTemperature;

  @override
  final num setpoint;

  @override
  final bool useRemote;

  AirConditionerLogJsonModel({
    this.offset,
    this.setpoint,
    this.isOn,
    this.useRemote,
    this.localTemperature,
    this.remoteTemperature,
    this.relayStatus,
  });
}
