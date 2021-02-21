import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_configuration.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_log.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_log_json.dart';

abstract class AirConditionerItem {
  AirConditionerConfiguration get configuration;
  AirConditionerLog get lastLog;
  AirConditionerLogJson get lastLogJson;
}
