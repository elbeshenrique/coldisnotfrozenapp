import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'package:guard_class/app/core/extensions/dartz_extensions.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_configuration.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/usecases/get_air_conditioner_item_model_list.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/usecases/save_air_conditioner_configuration.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/adapters/air_conditioner_configuration_adapter.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/adapters/air_conditioner_detail_view_model_adapter.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/states/air_conditioner_list_states.dart';

part 'ar_conditioner_list_controller.g.dart';

class AirConditionerListController = _AirConditionerListControllerBase with _$AirConditionerListController;

abstract class _AirConditionerListControllerBase with Store {
  final BaseAirConditionerDetailViewModelAdapter detailViewModelAdapter = Modular.get<BaseAirConditionerDetailViewModelAdapter>();
  final BaseAirConditionerConfigurationAdapter configurationAdapter = Modular.get<BaseAirConditionerConfigurationAdapter>();
  final BaseGetAirConditionerItemModelList getAirConditionerItemModelList;
  final BaseSaveAirConditionerConfiguration saveAirConditionerConfiguration;

  Future _loadDataFuture;
  CancelableOperation cancellableOperation;
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  _AirConditionerListControllerBase(this.getAirConditionerItemModelList, this.saveAirConditionerConfiguration);

  @observable
  AirConditionerListState state = StartAirConditionerListState();

  @action
  setState(AirConditionerListState value) => state = value;

  Future loadData([CancelableOperation cancellableOperation]) async {
    await cancellableOperation?.cancel();
    cancellableOperation = CancelableOperation<AirConditionerListState>.fromFuture(getData());
    setState(LoadingAirConditionerListState());
    setState(await cancellableOperation.valueOrCancellation(StartAirConditionerListState()));
  }

  Future<AirConditionerListState> getData() async {
    var result = await getAirConditionerItemModelList();
    return result.fold((l) => ErrorAirConditionerListState(l), (r) => SuccessAirConditionerListState(r));
  }

  Future<void> onRefreshIndicator() async {
    await (_loadDataFuture ?? loadData()).then((_) {
      // ignore: invalid_use_of_protected_member
      refreshIndicatorKey.currentState.deactivate();
    });

    _loadDataFuture = null;
  }

  Future openDetailForResult(AirConditionerConfiguration airConditionerConfigurationModel) async {
    final configuration = await Modular.to.pushNamed(
      "/air_conditioner/detail",
      arguments: detailViewModelAdapter.fromConfiguration(airConditionerConfigurationModel),
    );

    if (configuration == null) {
      return;
    }

    refreshIndicatorKey.currentState.show();
  }
}
