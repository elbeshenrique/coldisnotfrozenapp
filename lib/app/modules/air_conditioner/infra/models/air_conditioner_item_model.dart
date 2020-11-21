import 'dart:convert';

import 'air_conditioner_configuration_model.dart';
import 'air_conditioner_log_model.dart';

class AirConditionerItemModel {
  final AirConditionerConfigurationModel configuration;
  AirConditionerLogModel lastLog;
  
  AirConditionerItemModel({
    this.configuration,
    this.lastLog,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'configuration': configuration?.toMap(),
      'lastLog': lastLog?.toMap(),
    };
  }

  factory AirConditionerItemModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return AirConditionerItemModel(
      configuration: AirConditionerConfigurationModel.fromMap(map['configuration']),
      lastLog: AirConditionerLogModel.fromMap(map['lastLog']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AirConditionerItemModel.fromJson(String source) => AirConditionerItemModel.fromMap(json.decode(source));
}
