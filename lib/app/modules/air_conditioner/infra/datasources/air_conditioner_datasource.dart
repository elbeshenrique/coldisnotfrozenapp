import 'dart:async';

import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_configuration.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_log.dart';

abstract class AirConditionerDataSource {
  Future<AirConditionerConfiguration> getConfiguration(String id);
  Future<List<AirConditionerConfiguration>> getConfigurationList();
  Future<AirConditionerLog> getLastLog(String id);
  Future saveConfiguration(AirConditionerConfiguration airConditionerConfiguration);
}
