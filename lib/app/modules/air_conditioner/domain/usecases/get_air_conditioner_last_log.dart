import 'package:dartz/dartz.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_log.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/errors/errors.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/repositories/air_conditioner_repository.dart';

abstract class GetAirConditionerLastLog {
  Future<Either<AirConditionerFailure, AirConditionerLog>> call(String id);
}

class GetAirConditionerLastLogImpl implements GetAirConditionerLastLog {
  final AirConditionerRepository repository;

  GetAirConditionerLastLogImpl(this.repository);

  @override
  Future<Either<AirConditionerFailure, AirConditionerLog>> call(String id) async {
    try {
      return repository.getLastLog(id);
    } catch (e) {
      return Left(RepositoryError());
    }
  }
}
