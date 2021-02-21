import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_configuration.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/models/air_conditioner_configuration_model.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/viewmodels/air_conditioner_detail_viewmodel.dart';

abstract class BaseAirConditionerConfigurationAdapter {
  AirConditionerConfiguration fromDetailViewModel(AirConditionerDetailViewModel detailViewModel);
}

class AirConditionerConfigurationAdapter implements BaseAirConditionerConfigurationAdapter {
  AirConditionerConfiguration fromDetailViewModel(AirConditionerDetailViewModel detailViewModel) {
    if (detailViewModel == null) {
      return null;
    }

    return AirConditionerConfigurationModel(
      id: detailViewModel.id,
      offset: detailViewModel.offset,
      setpoint: detailViewModel.setpoint,
      isOn: detailViewModel.isOn,
      useRemote: detailViewModel.useRemote,
    );
  }
}
