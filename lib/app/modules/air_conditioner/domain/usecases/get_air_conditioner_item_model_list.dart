import 'package:dartz/dartz.dart';

import "package:guard_class/app/core/extensions/dartz_extensions.dart";
import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_configuration.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_item.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/errors/errors.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/repositories/air_conditioner_repository.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/models/air_conditioner_item_model.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/models/air_conditioner_log_json_model.dart';
import 'package:guard_class/app/modules/air_conditioner/utils/json_serializer.dart';

abstract class GetAirConditionerItemModelList {
  Future<Either<AirConditionerFailure, List<AirConditionerItem>>> call();
}

class GetAirConditionerItemModelListImpl implements GetAirConditionerItemModelList {
  final AirConditionerRepository repository;
  final BaseJsonSerializer jsonSerializer;

  GetAirConditionerItemModelListImpl(this.repository, this.jsonSerializer);

  @override
  Future<Either<AirConditionerFailure, List<AirConditionerItem>>> call() async {
    try {
      final result = await _getItemModelList();
      return Right(result);
    } catch (e) {
      return Left(GetAirConditionerItemModelListError(message: e.toString()));
    }
  }

  Future<List<AirConditionerItemModel>> _getItemModelList() async {
    final configurationListEither = await repository.getConfigurationList();
    if (configurationListEither.isLeft()) {
      throw configurationListEither.getLeft();
    }

    final configurationList = configurationListEither.getRight();
    final itemModelListEither = await _getItemModelListFromConfigurationList(configurationList);
    return itemModelListEither;
  }

  Future<List<AirConditionerItemModel>> _getItemModelListFromConfigurationList(List<AirConditionerConfiguration> configurationList) async {
    final airConditionerItemModelList = List<AirConditionerItemModel>();

    for (final configuration in configurationList) {
      final logEither = await repository.getLastLog(configuration.id);
      if (logEither.isLeft()) {
        throw logEither.getLeft();
      }

      final lastLog = logEither.getRight();
      final lastLogJson = jsonSerializer.deserialize<AirConditionerLogJsonModel>(lastLog?.json);

      airConditionerItemModelList.add(
        AirConditionerItemModel(
          configuration: configuration,
          lastLog: lastLog,
          lastLogJson: lastLogJson,
        ),
      );
    }

    return airConditionerItemModelList;
  }
}