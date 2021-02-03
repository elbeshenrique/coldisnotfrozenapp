import 'package:dartz/dartz.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_configuration.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/errors/errors.dart';

abstract class AirConditionerRepository {
  Future<Either<AirConditionerFailure, List<AirConditionerConfiguration>>> getConfigurationList();
}
