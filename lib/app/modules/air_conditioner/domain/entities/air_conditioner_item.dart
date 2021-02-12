import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_configuration.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_log.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_log_json.dart';

abstract class AirConditionerItem {
  final AirConditionerConfiguration configuration;
  final AirConditionerLog lastLog;
  final AirConditionerLogJson lastLogJson;

  AirConditionerItem({
    this.configuration,
    this.lastLog,
    this.lastLogJson,
  });
}
