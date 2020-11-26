import 'package:dart_json_mapper/dart_json_mapper.dart';

import 'air_conditioner_configuration_model.dart';
import 'air_conditioner_log_model.dart';

@jsonSerializable
class AirConditionerItemModel {
  final AirConditionerConfigurationModel configuration;
  AirConditionerLogModel lastLog;
  
  AirConditionerItemModel({
    this.configuration,
    this.lastLog,
  });

}
