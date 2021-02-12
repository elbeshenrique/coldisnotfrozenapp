import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_item.dart';

@jsonSerializable
class AirConditionerItemModel extends AirConditionerItem {
  AirConditionerItemModel({
    configuration,
    lastLog,
    lastLogJson,
  }) : super(
          configuration: configuration,
          lastLog: lastLog,
          lastLogJson: lastLogJson,
        );
}
