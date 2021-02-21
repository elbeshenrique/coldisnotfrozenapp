import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_configuration.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/errors/errors.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/repositories/air_conditioner_repository.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/usecases/get_air_conditioner_configuration.dart';

class AirConditionerRepositoryMock extends Mock implements AirConditionerRepository {}
class AirConditionerConfigurationMock extends Mock implements AirConditionerConfiguration {}

main() {
  final repository = AirConditionerRepositoryMock();
  final usecase = GetAirConditionerConfiguration(repository);

  test("should return AirConditionerConfiguration", () async {
    when(repository.getConfiguration(any)).thenAnswer((_) async => Right(AirConditionerConfigurationMock()));
    final result = await usecase("id");
    expect(result | null, isA<AirConditionerConfiguration>());
  });

  test("should return a RepositoryError if the repository fails", () async {
    when(repository.getConfiguration(any)).thenThrow(Exception());
    final result = await usecase("id");
    expect(result.fold(id, id), isA<RepositoryError>());
  });
}
