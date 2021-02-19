import 'package:flutter_test/flutter_test.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/adapters/air_conditioner_detail_view_model_adapter.dart';

import '../../utils/air_conditioner_utils.dart';

main() {
  final adapter = AirConditionerDetailViewModelAdapter();

  test('should return a AirConditionerConfiguration', () {
    final result = adapter.fromConfiguration(airConditionerConfigurationModelMock);
    expect(result.id, equals(airConditionerConfigurationModelMock.id));
    expect(result.setpoint, equals(airConditionerConfigurationModelMock.setpoint));
    expect(result.offset, equals(airConditionerConfigurationModelMock.offset));
    expect(result.isOn, equals(airConditionerConfigurationModelMock.isOn));
    expect(result.useRemote, equals(airConditionerConfigurationModelMock.useRemote));
  });
  test('should return null', () {
    final result = adapter.fromConfiguration(null);
    expect(result, equals(null));
  });
}
