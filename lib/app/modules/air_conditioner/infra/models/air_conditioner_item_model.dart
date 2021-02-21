import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_configuration.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_item.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_log_json.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_log.dart';

@jsonSerializable
class AirConditionerItemModel implements AirConditionerItem {

  @override
  final AirConditionerConfiguration configuration;

  @override
  final AirConditionerLog lastLog;

  @override
  final AirConditionerLogJson lastLogJson;

  AirConditionerItemModel({
    this.configuration,
    this.lastLog,
    this.lastLogJson,
  });
}
