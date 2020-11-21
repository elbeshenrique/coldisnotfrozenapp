import 'dart:async';

import 'package:guard_class/app/modules/air_conditioner/infra/models/air_conditioner_configuration_model.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/models/air_conditioner_log_model.dart';

abstract class AirConditionerDataSource {
  Future<List<AirConditionerConfigurationModel>> getConfigurationList();
  Future<AirConditionerLogModel> getLastLog(String id);
}
