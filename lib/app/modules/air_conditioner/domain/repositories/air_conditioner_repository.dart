import 'package:dartz/dartz.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_configuration.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_log.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/errors/errors.dart';

abstract class AirConditionerRepository {
  Future<Either<AirConditionerError, AirConditionerConfiguration>> getConfiguration(String id);
  Future<Either<AirConditionerError, List<AirConditionerConfiguration>>> getConfigurationList();
  Future<Either<AirConditionerError, AirConditionerLog>> getLastLog(String id);
}
