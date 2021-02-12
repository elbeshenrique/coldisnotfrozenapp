import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_item.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/usecases/get_air_conditioner_item_model_list.dart';
import 'package:mobx/mobx.dart';

import "package:guard_class/app/core/extensions/dartz_extensions.dart";

part 'ar_conditioner_store.g.dart';

@Injectable()
class AirConditionerStore = _AirConditionerStoreBase with _$AirConditionerStore;

abstract class _AirConditionerStoreBase with Store {
  _AirConditionerStoreBase();

  @observable
  ObservableList<AirConditionerItem> airConditionerConfigurationList = ObservableList<AirConditionerItem>();

  @computed
  bool get isLoaded {
    if (airConditionerConfigurationList == null) {
      return false;
    }

    return airConditionerConfigurationList.length > 0;
  }

  @action
  void _setAirConditionerConfigurationList(List<AirConditionerItem> value) {
    airConditionerConfigurationList = value.asObservable();
  }

  Future loadItemModelList() async {
    try {
      final getAirConditionerItemModelListUsecase = Modular.get<GetAirConditionerItemModelList>();
      final airConditionerItemModelListEither = await getAirConditionerItemModelListUsecase();
      if (airConditionerItemModelListEither.isFailure(handleException)) {
        return;
      }

      final airConditionerItemModelList = airConditionerItemModelListEither.getRight();
      _setAirConditionerConfigurationList(airConditionerItemModelList);
    } catch (e) {
      handleException(e);
    }
  }

  handleException(Exception exception) {
    asuka.showSnackBar(SnackBar(content: Text(exception.toString() ?? "")));
  }
}
