import 'dart:convert';

import "../../domain/entities/air_conditioner.dart";

class AirConditionerModel implements AirConditioner {
  final double offset;
  final int setpoint;
  final bool isOn;
  final bool useRemote;

  const AirConditionerModel({this.offset, this.setpoint, this.isOn, this.useRemote});


  Map<String, dynamic> toMap() {
    return {
      'offset': offset,
      'setpoint': setpoint,
      'isOn': isOn,
      'useRemote': useRemote,
    };
  }

  factory AirConditionerModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return AirConditionerModel(
      offset: map['offset'],
      setpoint: map['setpoint'],
      isOn: map['isOn'],
      useRemote: map['useRemote'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AirConditionerModel.fromJson(String source) => AirConditionerModel.fromMap(json.decode(source));
}
