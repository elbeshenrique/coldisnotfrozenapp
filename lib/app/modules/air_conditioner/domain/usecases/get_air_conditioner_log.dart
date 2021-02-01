import 'package:dartz/dartz.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_log.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/errors/errors.dart';

abstract class GetAirConditionerLog {
  Future<Either<AirConditionerFailure, List<AirConditionerLog>>> call();
}

class GetAirConditionerLogImpl implements GetAirConditionerLog {
  
  @override
  Future<Either<AirConditionerFailure, List<AirConditionerLog>>> call() async {
    
  }
  
}
