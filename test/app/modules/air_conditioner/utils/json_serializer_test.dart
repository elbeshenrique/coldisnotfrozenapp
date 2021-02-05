import 'dart:convert';

import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dart_json_mapper_mobx/dart_json_mapper_mobx.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/models/air_conditioner_configuration_model.dart';
import 'package:guard_class/app/modules/air_conditioner/utils/json_serializer.dart';
import 'package:guard_class/main.mapper.g.dart';
import 'package:mockito/mockito.dart';

import 'air_conditioner_utils.dart';

main() {
  initializeJsonMapper();
  JsonMapper().useAdapter(mobXAdapter);

  final jsonSerializer = DartJsonMapperSerializer();
  final jsonMap = jsonDecode(airConditionerConfigurationListResponseData);
  final jsonDataField = jsonMap["data"];
  final jsonAirConditionerConfigurationField = jsonDataField["airconditioner_configuration"];

  test("desserialize should return Map", () {
    final Map result = jsonSerializer.deserialize(airConditionerConfigurationListResponseData);
    expect(result, isA<Map>());
  });
  test("adaptList should return List<AirConditionerConfigurationModel>", () {
    final result = jsonSerializer.adaptList<AirConditionerConfigurationModel>(jsonAirConditionerConfigurationField);
    expect(result, isA<List<AirConditionerConfigurationModel>>());
  });
  test("adaptList should return List<AirConditionerConfigurationModel> with one element as it is on json mock", () {
    final result = jsonSerializer.adaptList<AirConditionerConfigurationModel>(jsonAirConditionerConfigurationField);
    final firstResult = result[0];
    expect(firstResult.id, equals(airConditionerConfigurationModelMock.id));
    expect(firstResult.offset, equals(airConditionerConfigurationModelMock.offset));
    expect(firstResult.setpoint, equals(airConditionerConfigurationModelMock.setpoint));
    expect(firstResult.useRemote, equals(airConditionerConfigurationModelMock.useRemote));
    expect(firstResult.isOn, equals(airConditionerConfigurationModelMock.isOn));
  });
}
