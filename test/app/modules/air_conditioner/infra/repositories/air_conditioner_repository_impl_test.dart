import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_configuration.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_log.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/errors/errors.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/datasources/air_conditioner_datasource.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/models/air_conditioner_configuration_model.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/models/air_conditioner_log_model.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/repositories/air_conditioner_repository_impl.dart';
import 'package:mockito/mockito.dart';

class AirConditionerDataSourceMock extends Mock implements AirConditionerDataSource {}

class AirConditionerLogModelMock extends Mock implements AirConditionerLogModel {}

main() {
  final datasource = AirConditionerDataSourceMock();
  final repository = AirConditionerRepositoryImpl(datasource);


  group("getConfiguration", () {
    test("should return AirConditionerConfiguration", () async {
      when(datasource.getConfiguration(any)).thenAnswer((_) async => AirConditionerConfigurationModel());
      final result = await repository.getConfiguration("id");
      expect(result | null, isA<AirConditionerConfiguration>());
    });

    test("should return an RepositoryError if the datasource fails", () async {
      when(datasource.getConfiguration(any)).thenThrow(Exception());
      final result = await repository.getConfiguration("id");
      expect(result.fold(id, id), isA<RepositoryError>());
    });

    test("should return an DatasourceError if the datasource fails", () async {
      when(datasource.getConfiguration(any)).thenThrow(DatasourceError());
      final result = await repository.getConfiguration("id");
      expect(result.fold(id, id), isA<DatasourceError>());
    });
  });

  group("getConfigurationList", () {
    test("should return a list of AirConditionerConfiguration", () async {
      when(datasource.getConfigurationList()).thenAnswer((_) async => <AirConditionerConfigurationModel>[]);
      final result = await repository.getConfigurationList();
      expect(result | null, isA<List<AirConditionerConfiguration>>());
    });

    test("should return an RepositoryError if the datasource fails", () async {
      when(datasource.getConfigurationList()).thenThrow(Exception());
      final result = await repository.getConfigurationList();
      expect(result.fold(id, id), isA<RepositoryError>());
    });

    test("should return an DatasourceError if the datasource fails", () async {
      when(datasource.getConfigurationList()).thenThrow(DatasourceError());
      final result = await repository.getConfigurationList();
      expect(result.fold(id, id), isA<DatasourceError>());
    });
  });

  group("getLastLog", () {
    test("should return a list of AirConditionerConfiguration", () async {
      when(datasource.getLastLog(any)).thenAnswer((_) async => AirConditionerLogModelMock());
      final result = await repository.getLastLog("id");
      expect(result | null, isA<AirConditionerLog>());
    });

    test("should return an RepositoryError if the datasource fails", () async {
      when(datasource.getLastLog(any)).thenThrow(Exception());
      final result = await repository.getLastLog("id");
      expect(result.fold(id, id), isA<RepositoryError>());
    });

    test("should return an DatasourceError if the datasource fails", () async {
      when(datasource.getLastLog(any)).thenThrow(DatasourceError());
      final result = await repository.getLastLog("id");
      expect(result.fold(id, id), isA<DatasourceError>());
    });
  });
}
