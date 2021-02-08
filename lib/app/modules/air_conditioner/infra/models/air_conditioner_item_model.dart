import 'package:dart_json_mapper/dart_json_mapper.dart';

import 'air_conditioner_configuration_model.dart';
import 'air_conditioner_log_json_model.dart';
import 'air_conditioner_log_model.dart';

@jsonSerializable
class AirConditionerItemModel {
  final AirConditionerConfigurationModel configuration;
  final AirConditionerLogModel lastLog;
  final AirConditionerLogJsonModel lastLogJson;

  AirConditionerItemModel({
    this.configuration,
    this.lastLog,
    this.lastLogJson,
  });
}
