import 'package:dartz/dartz.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_configuration.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/errors/errors.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/repositories/air_conditioner_repository.dart';

abstract class GetAirConditionerConfigurationList {
  Future<Either<AirConditionerError, List<AirConditionerConfiguration>>> call();
}

class GetAirConditionerConfigurationListImpl implements GetAirConditionerConfigurationList {
  final AirConditionerRepository repository;

  GetAirConditionerConfigurationListImpl(this.repository);

  @override
  Future<Either<AirConditionerError, List<AirConditionerConfiguration>>> call() async {
    try {
      return repository.getConfigurationList();
    } catch (e) {
      return Left(RepositoryError());
    }
  }
}
