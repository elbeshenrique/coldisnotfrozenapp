import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/modules/air_conditioner/external/datasources/air_conditioner_hasura_datasource.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/models/air_conditioner_configuration_model.dart';
import 'package:mobx/mobx.dart';

part 'ar_conditioner_store.g.dart';

@Injectable()
class AirConditionerStore = _AirConditionerStoreBase with _$AirConditionerStore;

abstract class _AirConditionerStoreBase with Store {
  
  _AirConditionerStoreBase();

  @observable
  ObservableList<AirConditionerConfigurationModel> airConditionerConfigurationList = ObservableList<AirConditionerConfigurationModel>();

  @computed
  bool get isLoaded {
    return airConditionerConfigurationList?.length > 0;
  }

  @action
  void setAirConditionerConfigurationList(ObservableList<AirConditionerConfigurationModel> value) {
    airConditionerConfigurationList = value;
  }

  @action
  Future<void> getData() async {
    var clienteResult = await repository.getAllClientes();
    data = clienteResult?.asObservable();
  }

  Future getFirstAirConditionerConfig() async {
    var dio = Modular.get<Dio>();
    var dataSource = AirConditionerHasuraDataSource(dio);
    var airConditionerModel = await dataSource.getConfig("467683a1-2212-4113-bc05-631d32cde51f");
    setAirConditionerConfigurationList(airConditionerModel);
  }
}
