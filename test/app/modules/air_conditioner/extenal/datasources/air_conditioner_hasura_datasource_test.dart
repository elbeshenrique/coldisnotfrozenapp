import 'dart:convert';

import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dart_json_mapper_mobx/dart_json_mapper_mobx.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/errors/errors.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/models/air_conditioner_log_model.dart';
import 'package:guard_class/app/modules/air_conditioner/utils/json_serializer.dart';
import 'package:guard_class/main.mapper.g.dart';
import 'package:mockito/mockito.dart';

import 'package:guard_class/app/app_module.dart';
import 'package:guard_class/app/modules/air_conditioner/external/datasources/air_conditioner_hasura_datasource.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/models/air_conditioner_configuration_model.dart';

import '../../utils/air_conditioner_utils.dart';

class DioMock extends Mock implements Dio {}

class JsonSerializerMock extends Mock implements BaseJsonSerializer {}

main() {
  initializeJsonMapper();
  JsonMapper().useAdapter(mobXAdapter);
  
  // final jsonSerializerMock = JsonSerializerMock();
  final dioMock = DioMock();

  initModule(AppModule(), changeBinds: [
    // Bind((i) => jsonSerializerMock),
  ]);

  final datasource = AirConditionerHasuraDataSource(dioMock);

  setUpAll(() {
    // when(jsonSerializerMock.adapt<AirConditionerLogModel>(any)).thenReturn(airConditionerLogModelMock);
    // when(jsonSerializerMock.adaptList<AirConditionerConfigurationModel>(any)).thenReturn(<AirConditionerConfigurationModel>[
    //   airConditionerConfigurationModelMock
    // ]);
  });

  group("getConfigurationList", () {
    test("should return a list of AirConditionerConfigurationModel", () async {
      when(dioMock.post(any, data: anyNamed("data"), options: anyNamed("options"))).thenAnswer(
        (_) async => Response(data: jsonDecode(airConditionerConfigurationListResponseData), statusCode: 200),
      );
      final result = await datasource.getConfigurationList();
      expect(result, isA<List<AirConditionerConfigurationModel>>());
    });
    test("should return an error if statusCode is not 200", () async {
      when(dioMock.post(any, data: anyNamed("data"), options: anyNamed("options"))).thenAnswer(
        (_) async => Response(data: null, statusCode: 401),
      );
      final future = datasource.getConfigurationList();
      expect(future, throwsA(isA<DatasourceError>()));
    });
  });

  group("getLastLog", () {
    test("should return AirConditionerLogModel", () async {
      when(dioMock.post(any, data: anyNamed("data"), options: anyNamed("options"))).thenAnswer(
        (_) async => Response(data: jsonDecode(airConditionerLogListResponseData), statusCode: 200),
      );
      final result = await datasource.getLastLog("id");
      expect(result, isA<AirConditionerLogModel>());
    });
  });
}
