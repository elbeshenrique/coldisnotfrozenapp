import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_configuration.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/viewmodels/air_conditioner_detail_viewmodel.dart';

class AirConditionerDetailViewModelAdapter {
  AirConditionerDetailViewModel fromConfiguration(AirConditionerConfiguration configuration) {
    if (configuration == null) {
      return null;
    }

    return AirConditionerDetailViewModel(
      id: configuration.id,
      offset: configuration.offset,
      setpoint: configuration.setpoint,
      isOn: configuration.isOn,
      useRemote: configuration.useRemote,
    );
  }
}
