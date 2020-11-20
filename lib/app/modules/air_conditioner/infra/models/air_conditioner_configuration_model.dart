import 'dart:convert';

import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_configuration.dart';

class AirConditionerConfigurationModel implements AirConditionerConfiguration {
  final double offset;
  final int setpoint;
  final bool isOn;
  final bool useRemote;

  const AirConditionerConfigurationModel({this.offset, this.setpoint, this.isOn, this.useRemote});

  Map<String, dynamic> toMap() {
    return {
      'offset': offset,
      'setpoint': setpoint,
      'isOn': isOn,
      'useRemote': useRemote,
    };
  }

  factory AirConditionerConfigurationModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return AirConditionerConfigurationModel(
      offset: map['offset'],
      setpoint: map['setpoint'],
      isOn: map['isOn'],
      useRemote: map['useRemote'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AirConditionerConfigurationModel.fromJson(String source) => AirConditionerConfigurationModel.fromMap(json.decode(source));
}
