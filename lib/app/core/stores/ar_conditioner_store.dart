import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/modules/air_conditioner/external/datasources/air_conditioner_hasura_datasource.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/models/air_conditioner_model.dart';
import 'package:mobx/mobx.dart';

part 'ar_conditioner_store.g.dart';

@Injectable()
class AirConditionerStore = _AirConditionerStoreBase with _$AirConditionerStore;

abstract class _AirConditionerStoreBase with Store {
  
  _AirConditionerStoreBase();

  @observable
  AirConditionerModel airConditioner;

  @computed
  bool get isLoaded {
    return airConditioner != null;
  }

  @action
  void setAirConditioner(AirConditionerModel value) {
    airConditioner = value;
  }

  Future getFirstAirConditionerConfig() async {
    var dio = Modular.get<Dio>();
    var dataSource = AirConditionerHasuraDataSource(dio);
    var airConditionerModel = await dataSource.getConfig("467683a1-2212-4113-bc05-631d32cde51f");
    setAirConditioner(airConditionerModel);
  }
}
