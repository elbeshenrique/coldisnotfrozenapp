import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_configuration.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_item.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_log.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/errors/errors.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/repositories/air_conditioner_repository.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/usecases/get_air_conditioner_item_model_list.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/models/air_conditioner_item_model.dart';
import 'package:guard_class/app/modules/air_conditioner/utils/json_serializer.dart';
import 'package:mockito/mockito.dart';

class AirConditionerConfigurationMock extends Mock implements AirConditionerConfiguration {}

class AirConditionerLogMock extends Mock implements AirConditionerLog {}

class AirConditionerItemModelMock extends Mock implements AirConditionerItemModel {}

class AirConditionerRepositoryMock extends Mock implements AirConditionerRepository {}

class BaseJsonSerializerMock extends Mock implements BaseJsonSerializer {}

main() {
  final repositoryMock = AirConditionerRepositoryMock();
  final baseJsonSerializerMock = BaseJsonSerializerMock();
  final usecase = GetAirConditionerItemModelListImpl(repositoryMock, baseJsonSerializerMock);

  test("should return a list of AirConditionerItem", () async {
    when(repositoryMock.getConfigurationList()).thenAnswer(
      (_) async => Right(
        <AirConditionerConfigurationMock>[
          AirConditionerConfigurationMock()
        ],
      ),
    );
    when(repositoryMock.getLastLog(any)).thenAnswer((_) async => Right(AirConditionerLogMock()));
    final result = await usecase();
    expect(result | null, isA<List<AirConditionerItem>>());
  });
  test("should return a GetAirConditionerItemModelListError if the repository fails on getConfigurationList", () async {
    when(repositoryMock.getConfigurationList()).thenThrow(Exception());
    final result = await usecase();
    expect(result.fold(id, id), isA<GetAirConditionerItemModelListError>());
  });
  test("should return a GetAirConditionerItemModelListError if the repository fails on getLastLog", () async {
    when(repositoryMock.getLastLog(any)).thenThrow(Exception());
    final result = await usecase();
    expect(result.fold(id, id), isA<GetAirConditionerItemModelListError>());
  });
  test("should return a GetAirConditionerItemModelListError if the BaseJsonSerializer fails", () async {
    when(repositoryMock.getConfigurationList()).thenAnswer(
      (_) async => Right(
        <AirConditionerConfigurationMock>[
          AirConditionerConfigurationMock()
        ],
      ),
    );
    when(repositoryMock.getLastLog(any)).thenAnswer((_) async => Right(AirConditionerLogMock()));
    when(baseJsonSerializerMock.deserialize(any)).thenThrow(Exception());
    final result = await usecase();
    expect(result.fold(id, id), isA<GetAirConditionerItemModelListError>());
  });
}
