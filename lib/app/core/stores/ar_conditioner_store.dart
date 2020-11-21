import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/modules/air_conditioner/external/datasources/air_conditioner_hasura_datasource.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/models/air_conditioner_item_model.dart';
import 'package:mobx/mobx.dart';

part 'ar_conditioner_store.g.dart';

@Injectable()
class AirConditionerStore = _AirConditionerStoreBase with _$AirConditionerStore;

abstract class _AirConditionerStoreBase with Store {
  _AirConditionerStoreBase();

  @observable
  ObservableList<AirConditionerItemModel> airConditionerConfigurationList = ObservableList<AirConditionerItemModel>();

  @computed
  bool get isLoaded {
    return airConditionerConfigurationList?.length > 0;
  }

  @action
  void setAirConditionerConfigurationList(List<AirConditionerItemModel> value) {
    airConditionerConfigurationList = value.asObservable();
  }

  @action
  Future<void> getData() async {
    // var clienteResult = await repository.getAllClientes();
    // data = clienteResult?.asObservable();
  }

  Future getConfigurationList() async {
    var dio = Modular.get<Dio>();
    var dataSource = AirConditionerHasuraDataSource(dio);
    var airConditionerConfigurationModelList = await dataSource.getConfigurationList();
    var airConditionerItemModelList = airConditionerConfigurationModelList.map((item) => AirConditionerItemModel(configuration: item)).toList();
    
    for(var airConditionerItemModel in airConditionerItemModelList) {
      var airConditionerLog = await dataSource.getLastLog(airConditionerItemModel.configuration.id);  
      airConditionerItemModel.lastLog = airConditionerLog;
    };
    
    setAirConditionerConfigurationList(airConditionerItemModelList);
  }
}
