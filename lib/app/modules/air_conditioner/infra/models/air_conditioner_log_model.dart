import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_log.dart';

@jsonSerializable
class AirConditionerLogModel extends AirConditionerLog {
  AirConditionerLogModel({
    createdAt,
    json,
  }) : super(
          createdAt: createdAt,
          json: json,
        );
}
