import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:guard_class/app/modules/air_conditioner/domain/repositories/air_conditioner_repository.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/usecases/get_air_conditioner_item_model_list.dart';
import 'package:guard_class/app/modules/air_conditioner/external/datasources/air_conditioner_hasura_datasource.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/datasources/air_conditioner_datasource.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/repositories/air_conditioner_repository_impl.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/controllers/ar_conditioner_list_controller.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/pages/air_conditioner_detail_page.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/pages/air_conditioner_list_page.dart';
import 'package:guard_class/app/modules/air_conditioner/utils/json_serializer.dart';

class AirConditionerModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind<Dio>((i) => Dio()),
        Bind<BaseJsonSerializer>((i) => DartJsonMapperSerializer()),
        Bind<AirConditionerDataSource>((i) => AirConditionerHasuraDataSource(i(), i())),
        Bind<AirConditionerRepository>((i) => AirConditionerRepositoryImpl(i())),
        Bind<GetAirConditionerItemModelList>((i) => GetAirConditionerItemModelListImpl(i(), i())),
        Bind<AirConditionerListController>((i) => AirConditionerListController(i())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => AirConditionerListPage()),
        ModularRouter("/detail", child: (_, args) {
          return AirConditionerDetailPage(args.data);
        }),
      ];
}
