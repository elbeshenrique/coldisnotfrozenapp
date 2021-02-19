import 'package:async/async.dart';
import 'package:mobx/mobx.dart';

import 'package:guard_class/app/modules/air_conditioner/domain/usecases/get_air_conditioner_item_model_list.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/states/air_conditioner_states.dart';

part 'ar_conditioner_list_controller.g.dart';

class AirConditionerListController = _AirConditionerListControllerBase with _$AirConditionerListController;

abstract class _AirConditionerListControllerBase with Store {
  final GetAirConditionerItemModelList getAirConditionerItemModelList;
  CancelableOperation cancellableOperation;

  _AirConditionerListControllerBase(this.getAirConditionerItemModelList) {
    stateReaction(cancellableOperation);
  }

  @observable
  AirConditionerState state = StartAirConditionerState();

  @action
  setState(AirConditionerState value) => state = value;

  Future stateReaction([CancelableOperation cancellableOperation]) async {
    await cancellableOperation?.cancel();
    cancellableOperation = CancelableOperation<AirConditionerState>.fromFuture(getData());

    setState(LoadingAirConditionerState());

    setState(await cancellableOperation.valueOrCancellation(LoadingAirConditionerState()));
  }

  Future<AirConditionerState> getData() async {
    var result = await getAirConditionerItemModelList();
    return result.fold((l) => ErrorAirConditionerState(l), (r) => SuccessAirConditionerState(r));
  }

  Future loadData() async {
    setState(await getData());
  }
}
