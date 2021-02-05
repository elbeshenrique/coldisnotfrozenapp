import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/usecases/get_air_conditioner_configuration_list.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/models/air_conditioner_item_model.dart';
import 'package:mobx/mobx.dart';
import 'package:asuka/asuka.dart' as asuka;

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
    final usecase = Modular.get<GetAirConditionerConfigurationListImpl>();
    final result = await usecase();
    result.fold(
      (failure) {
        asuka.showSnackBar(SnackBar(content: Text(failure.message)));
      },
      (airConditionerConfigurationList) {
        final airConditionerItemModelList = airConditionerConfigurationList.map((item) => AirConditionerItemModel(configuration: item)).toList();
        for (final airConditionerItemModel in airConditionerItemModelList) {
          // final airConditionerLog = await dataSource.getLastLog(airConditionerItemModel.configuration.id);
          // itemModel.lastLog = airConditionerLog;
        }

        _setAirConditionerConfigurationList(airConditionerItemModelList);
      },
    );
  }
}
