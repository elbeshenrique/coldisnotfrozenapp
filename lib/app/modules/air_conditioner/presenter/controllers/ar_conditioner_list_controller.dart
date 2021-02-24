import 'package:async/async.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/material/refresh_indicator.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/models/air_conditioner_item_model.dart';
import 'package:mobx/mobx.dart';

import 'package:guard_class/app/core/extensions/dartz_extensions.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_configuration.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/usecases/get_air_conditioner_item_model_list.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/usecases/save_air_conditioner_configuration.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/adapters/air_conditioner_configuration_adapter.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/adapters/air_conditioner_detail_view_model_adapter.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/states/air_conditioner_states.dart';

part 'ar_conditioner_list_controller.g.dart';

class AirConditionerListController = _AirConditionerListControllerBase with _$AirConditionerListController;

abstract class _AirConditionerListControllerBase with Store {
  final BaseAirConditionerDetailViewModelAdapter detailViewModelAdapter = Modular.get<BaseAirConditionerDetailViewModelAdapter>();
  final BaseAirConditionerConfigurationAdapter configurationAdapter = Modular.get<BaseAirConditionerConfigurationAdapter>();
  final BaseGetAirConditionerItemModelList getAirConditionerItemModelList;
  final BaseSaveAirConditionerConfiguration saveAirConditionerConfiguration;

  CancelableOperation cancellableOperation;
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  _AirConditionerListControllerBase(this.getAirConditionerItemModelList, this.saveAirConditionerConfiguration);

  @observable
  AirConditionerState state = StartAirConditionerState();

  @action
  setState(AirConditionerState value) => state = value;

  Future loadData([CancelableOperation cancellableOperation]) async {
    await cancellableOperation?.cancel();
    cancellableOperation = CancelableOperation<AirConditionerState>.fromFuture(getData());
    setState(LoadingAirConditionerState());
    setState(await cancellableOperation.valueOrCancellation(StartAirConditionerState()));
  }

  Future<AirConditionerState> getData() async {
    var result = await getAirConditionerItemModelList();
    return result.fold((l) => ErrorAirConditionerState(l), (r) => SuccessAirConditionerState(r));
  }

  Future openDetail(AirConditionerConfiguration airConditionerConfigurationModel) async {
    final detailViewModel = await Modular.to.pushNamed(
      "/air_conditioner/detail",
      arguments: detailViewModelAdapter.fromConfiguration(airConditionerConfigurationModel),
    );

    if (detailViewModel == null) {
      return;
    }

    final configurationModel = configurationAdapter.fromDetailViewModel(detailViewModel);
    final saveConfigurationEither = await saveAirConditionerConfiguration(configurationModel);
    if (saveConfigurationEither.isLeft()) {
      throw saveConfigurationEither.getLeft();
    }

    if (state is SuccessAirConditionerState) {
      final model = ((state as SuccessAirConditionerState).list[1] as AirConditionerItemModel);
      (state as SuccessAirConditionerState).list[1] = AirConditionerItemModel(
        lastLog: model.lastLog,
        lastLogJson: model.lastLogJson,
        configuration: configurationModel
      );
      setState(state);
    }

    refreshIndicatorKey.currentState.show();
  }
}
