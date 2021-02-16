import 'package:async/async.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/usecases/get_air_conditioner_item_model_list.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/states/air_conditioner_states.dart';
import 'package:mobx/mobx.dart';

part 'ar_conditioner_store.g.dart';

@Injectable()
class AirConditionerStore = _AirConditionerStoreBase with _$AirConditionerStore;

abstract class _AirConditionerStoreBase with Store {
  final GetAirConditionerItemModelList getAirConditionerItemModelList;
  CancelableOperation cancellableOperation;

  _AirConditionerStoreBase(this.getAirConditionerItemModelList) {
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
