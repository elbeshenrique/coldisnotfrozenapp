import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/usecases/get_air_conditioner_item_model_list.dart';
import 'package:guard_class/app/modules/air_conditioner/external/datasources/air_conditioner_hasura_datasource.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/repositories/air_conditioner_repository_impl.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/air_conditioner_page.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/ar_conditioner_store.dart';
import 'package:guard_class/app/modules/air_conditioner/utils/json_serializer.dart';

class AirConditionerModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => Dio()),
        $AirConditionerStore,
        Bind((i) => DartJsonMapperSerializer()),
        Bind((i) => AirConditionerHasuraDataSource(i())),
        Bind((i) => AirConditionerRepositoryImpl(i())),
        Bind((i) => GetAirConditionerItemModelListImpl(i(), i())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => AirConditionerPage()),
      ];
}
