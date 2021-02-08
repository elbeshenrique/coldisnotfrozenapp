import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_log_json.dart';

@jsonSerializable
class AirConditionerLogJsonModel extends AirConditionerLogJson {
  AirConditionerLogJsonModel({
    offset,
    setpoint,
    isOn,
    useRemote,
    localTemperature,
    remoteTemperature,
    relayStatus,
  }) : super(
          offset: offset,
          setpoint: setpoint,
          isOn: isOn,
          useRemote: useRemote,
          localTemperature: localTemperature,
          remoteTemperature: remoteTemperature,
          relayStatus: relayStatus,
        );
}
