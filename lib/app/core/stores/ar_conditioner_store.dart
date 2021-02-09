import 'package:asuka/asuka.dart' as asuka;
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import "package:guard_class/app/core/extensions/dartz_extensions.dart";
import 'package:guard_class/app/modules/air_conditioner/domain/usecases/get_air_conditioner_configuration_list.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/usecases/get_air_conditioner_last_log.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/models/air_conditioner_item_model.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/models/air_conditioner_log_json_model.dart';
import 'package:guard_class/app/modules/air_conditioner/utils/json_serializer.dart';

part 'ar_conditioner_store.g.dart';

@Injectable()
class AirConditionerStore = _AirConditionerStoreBase with _$AirConditionerStore;

abstract class _AirConditionerStoreBase with Store {
  _AirConditionerStoreBase();

  @observable
  ObservableList<AirConditionerItemModel> airConditionerConfigurationList = ObservableList<AirConditionerItemModel>();

  @computed
  bool get isLoaded {
    if (airConditionerConfigurationList == null) {
      return false;
    }

    return airConditionerConfigurationList.length > 0;
  }

  @action
  void _setAirConditionerConfigurationList(List<AirConditionerItemModel> value) {
    airConditionerConfigurationList = value.asObservable();
  }

  Future getConfigurationList() async {
    try {
      final configurationListUsecase = Modular.get<GetAirConditionerConfigurationList>();
      final lastLogUsecase = Modular.get<GetAirConditionerLastLog>();
      final airConditionerItemModelList = List<AirConditionerItemModel>();
      final jsonSerializer = Modular.get<BaseJsonSerializer>();

      final configurationListEither = await configurationListUsecase();
      if (configurationListEither.isLeft()) {
        throw configurationListEither.foldAlwaysLeft();
      }
      final configurationList = configurationListEither.foldAlwaysRight();

      for (final configuration in configurationList) {
        final logEither = await lastLogUsecase(configuration.id);
        if (logEither.isLeft()) {
          throw logEither.foldAlwaysLeft();
        }
        final log = logEither.foldAlwaysRight();

        var logJson = jsonSerializer.deserialize<AirConditionerLogJsonModel>(log?.json);

        airConditionerItemModelList.add(AirConditionerItemModel(
          configuration: configuration,
          lastLog: log,
          lastLogJson: logJson,
        ));
      }

      _setAirConditionerConfigurationList(airConditionerItemModelList);
    } catch (e) {
      handleException(e);
    }
  }

  handleException(dynamic exception) {
    asuka.showSnackBar(SnackBar(content: Text(exception.toString() ?? "")));
  }
}
