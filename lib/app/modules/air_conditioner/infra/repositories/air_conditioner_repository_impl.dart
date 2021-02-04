import 'package:dartz/dartz.dart';

import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_configuration.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/errors/errors.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/repositories/air_conditioner_repository.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/datasources/air_conditioner_datasource.dart';

class AirConditionerRepositoryImpl implements AirConditionerRepository {
  final AirConditionerDataSource datasource;

  AirConditionerRepositoryImpl(this.datasource);

  @override
  Future<Either<AirConditionerFailure, List<AirConditionerConfiguration>>> getConfigurationList() async {
    try {
      final result = await datasource.getConfigurationList();
      return Right(result);
    } on DatasourceError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DatasourceError());
    }
  }
}
