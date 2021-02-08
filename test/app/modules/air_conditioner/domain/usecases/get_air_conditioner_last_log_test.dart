import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_log.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/errors/errors.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/repositories/air_conditioner_repository.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/usecases/get_air_conditioner_last_log.dart';
import 'package:mockito/mockito.dart';

class AirConditionerLogMock extends Mock implements AirConditionerLog {}

class AirConditionerRepositoryMock extends Mock implements AirConditionerRepository {}

main() {
  final repository = AirConditionerRepositoryMock();
  final usecase = GetAirConditionerLastLogImpl(repository);

  test("should return a list of AirConditionerLog", () async {
    when(repository.getLastLog(any)).thenAnswer((_) async => Right(AirConditionerLogMock()));
    final result = await usecase("id");
    expect(result | null, isA<AirConditionerLog>());
  });

  test("should return a RepositoryError if the repository fails", () async {
    when(repository.getLastLog(any)).thenThrow(Exception());
    final result = await usecase("id");
    expect(result.fold(id, id), isA<RepositoryError>());
  });
}
