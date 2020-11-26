import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_log.dart';

@jsonSerializable
class AirConditionerLogModel implements AirConditionerLog {
  final double offset;
  final num setpoint;
  final bool isOn;
  final bool useRemote;
  final double localTemperature;
  final num remoteTemperature;
  final bool relayStatus;

  String createdAt;

  AirConditionerLogModel({
    this.offset,
    this.setpoint,
    this.isOn,
    this.useRemote,
    this.localTemperature,
    this.remoteTemperature,
    this.relayStatus,
    this.createdAt,
  });
}
