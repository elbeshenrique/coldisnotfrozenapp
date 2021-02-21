import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_configuration.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/errors/errors.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/repositories/air_conditioner_repository.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/usecases/get_air_conditioner_configuration_list.dart';
import 'package:mockito/mockito.dart';

class AirConditionerRepositoryMock extends Mock implements AirConditionerRepository { }

main() {
  final repository = AirConditionerRepositoryMock();
  final usecase = GetAirConditionerConfigurationList(repository);

  test("should return a list of AirConditionerConfiguration", () async {
    when(repository.getConfigurationList()).thenAnswer((_) async => Right(<AirConditionerConfiguration>[]));
    final result = await usecase();
    expect(result | null, isA<List<AirConditionerConfiguration>>());
  });

  test("should return a RepositoryError if the repository fails", () async {
    when(repository.getConfigurationList()).thenThrow(Exception());
    final result = await usecase();
    expect(result.fold(id, id), isA<RepositoryError>());
  });
}
