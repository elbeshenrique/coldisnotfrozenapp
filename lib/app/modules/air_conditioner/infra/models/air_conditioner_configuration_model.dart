import 'package:dart_json_mapper/dart_json_mapper.dart' show jsonSerializable;
import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_configuration.dart';

@jsonSerializable
class AirConditionerConfigurationModel extends AirConditionerConfiguration {
  AirConditionerConfigurationModel({
    id,
    offset,
    setpoint,
    isOn,
    useRemote,
  }) : super(
          id: id,
          offset: offset,
          setpoint: setpoint,
          isOn: isOn,
          useRemote: useRemote,
        );
}
