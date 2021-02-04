import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guard_class/app/app_module.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/usecases/get_air_conditioner_configuration_list.dart';

main() {
  initModule(AppModule());

  test("should retrieve the usecase with no errors", () {
    final usecase = Modular.get<GetAirConditionerConfigurationList>();
    expect(usecase, isA<GetAirConditionerConfigurationList>());
  });
}
