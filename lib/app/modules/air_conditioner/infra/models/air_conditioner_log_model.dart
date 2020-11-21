import 'dart:convert';

import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_log.dart';

class AirConditionerLogModel implements AirConditionerLog {
  final double offset;
  final int setpoint;
  final bool isOn;
  final bool useRemote;
  final double localTemperature;
  final int remoteTemperature;
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
  

  Map<String, dynamic> toMap() {
    return {
      'offset': offset,
      'setpoint': setpoint,
      'isOn': isOn,
      'useRemote': useRemote,
      'localTemperature': localTemperature,
      'remoteTemperature': remoteTemperature,
      'relayStatus': relayStatus,
    };
  }

  factory AirConditionerLogModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return AirConditionerLogModel(
      offset: map['offset'],
      setpoint: map['setpoint'],
      isOn: map['isOn'],
      useRemote: map['useRemote'],
      localTemperature: map['localTemperature'],
      remoteTemperature: map['remoteTemperature'],
      relayStatus: map['relayStatus'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AirConditionerLogModel.fromJson(String source) => AirConditionerLogModel.fromMap(json.decode(source));
}
