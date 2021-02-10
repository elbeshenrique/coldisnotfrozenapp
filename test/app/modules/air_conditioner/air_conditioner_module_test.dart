import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guard_class/app/core/stores/ar_conditioner_store.dart';
import 'package:guard_class/app/modules/air_conditioner/air_conditioner_module.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/repositories/air_conditioner_repository.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/usecases/get_air_conditioner_configuration_list.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/usecases/get_air_conditioner_last_log.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/datasources/air_conditioner_datasource.dart';
import 'package:guard_class/app/modules/air_conditioner/utils/json_serializer.dart';

main() {
  initModule(AirConditionerModule());

  test("should retrieve Dio instance", () {
    final usecase = Modular.get<Dio>();
    expect(usecase, isA<Dio>());
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
  test("should retrieve GetAirConditionerConfigurationList instance", () {
    final usecase = Modular.get<GetAirConditionerConfigurationList>();
    expect(usecase, isA<GetAirConditionerConfigurationList>());
  });
  test("should retrieve GetAirConditionerLastLog instance", () {
    final usecase = Modular.get<GetAirConditionerLastLog>();
    expect(usecase, isA<GetAirConditionerLastLog>());
  });
  test("should retrieve AirConditionerStore instance", () {
    final usecase = Modular.get<AirConditionerStore>();
    expect(usecase, isA<AirConditionerStore>());
  });
}
