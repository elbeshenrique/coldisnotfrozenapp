import 'package:dartz/dartz.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_configuration.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/errors/errors.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/repositories/air_conditioner_repository.dart';

abstract class BaseSaveAirConditionerConfiguration {
  Future<Either<AirConditionerError, AirConditionerConfiguration>> call(AirConditionerConfiguration airConditionerConfiguration);
}

class SaveAirConditionerConfiguration implements BaseSaveAirConditionerConfiguration {
  final AirConditionerRepository repository;

  SaveAirConditionerConfiguration(this.repository);

  @override
  Future<Either<AirConditionerError, AirConditionerConfiguration>> call(AirConditionerConfiguration airConditionerConfiguration) async {
    try {
      return repository.saveConfiguration(airConditionerConfiguration);
    } catch (e) {
      return Left(SaveAirConditionerConfigurationError(message: e.toString()));
    }
  }
}
