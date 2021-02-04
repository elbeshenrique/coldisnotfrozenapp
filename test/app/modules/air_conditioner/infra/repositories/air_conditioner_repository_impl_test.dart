import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_configuration.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/errors/errors.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/datasources/air_conditioner_datasource.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/models/air_conditioner_configuration_model.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/repositories/air_conditioner_repository_impl.dart';
import 'package:mockito/mockito.dart';

class AirConditionerDataSourceMock extends Mock implements AirConditionerDataSource {}

main() {
  final datasource = AirConditionerDataSourceMock();
  final repository = AirConditionerRepositoryImpl(datasource);

  test("should return a list of AirConditionerConfiguration", () async {
    when(datasource.getConfigurationList()).thenAnswer((_) async => <AirConditionerConfigurationModel>[]);
    final result = await repository.getConfigurationList();
    expect(result | null, isA<List<AirConditionerConfiguration>>());
  });

  test("should return an DatasourceError if the datasource fails", () async {
    when(datasource.getConfigurationList()).thenThrow(Exception());
    final result = await repository.getConfigurationList();
    expect(result.fold(id, id), isA<DatasourceError>());
  });
}
