import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:guard_class/app/modules/air_conditioner/air_conditioner_module.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/repositories/air_conditioner_repository.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/usecases/get_air_conditioner_item_model_list.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/datasources/air_conditioner_datasource.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/controllers/ar_conditioner_list_controller.dart';
import 'package:guard_class/app/modules/air_conditioner/utils/json_serializer.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dioMock = DioMock();

  initModule(AirConditionerModule(), changeBinds: [
    Bind<Dio>((i) => dioMock),
  ]);

  test("should retrieve Dio instance", () {
    final usecase = Modular.get<Dio>();
    expect(usecase, isA<DioMock>());
  });
  test("should retrieve BaseMapperSerializer instance", () {
    final usecase = Modular.get<BaseJsonSerializer>();
    expect(usecase, isA<BaseJsonSerializer>());
  });
  test("should retrieve AirConditionerDataSource instance", () {
    final usecase = Modular.get<AirConditionerDataSource>();
    expect(usecase, isA<AirConditionerDataSource>());
  });
  test("should retrieve AirConditionerRepository instance", () {
    final usecase = Modular.get<AirConditionerRepository>();
    expect(usecase, isA<AirConditionerRepository>());
  });
  test("should retrieve GetAirConditionerItemModelList instance", () {
    final usecase = Modular.get<BaseGetAirConditionerItemModelList>();
    expect(usecase, isA<BaseGetAirConditionerItemModelList>());
  });
  test("should retrieve AirConditionerListController instance", () {
    final usecase = Modular.get<AirConditionerListController>();
    expect(usecase, isA<AirConditionerListController>());
  });
}
