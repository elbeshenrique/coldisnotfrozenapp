import 'package:dartz/dartz.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_configuration.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/errors/errors.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/repositories/air_conditioner_repository.dart';

abstract class GetAirConditionerConfiguration {
  Future<Either<AirConditionerError, AirConditionerConfiguration>> call(String id);
}

class GetAirConditionerConfigurationImpl implements GetAirConditionerConfiguration {
  final AirConditionerRepository repository;

  GetAirConditionerConfigurationImpl(this.repository);

  @override
  Future<Either<AirConditionerError, AirConditionerConfiguration>> call(String id) async {
    try {
      return repository.getConfiguration(id);
    } catch (e) {
      return Left(RepositoryError());
    }
  }
}
