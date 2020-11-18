import 'dart:async';

import 'package:guard_class/app/modules/air_conditioner/infra/models/air_conditioner_model.dart';

abstract class AirConditionerDataSource {
  Future<AirConditionerModel> getConfig(String id);
}
