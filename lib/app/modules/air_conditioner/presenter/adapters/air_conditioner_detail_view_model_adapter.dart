import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_configuration.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/viewmodels/air_conditioner_detail_viewmodel.dart';

abstract class BaseAirConditionerDetailViewModelAdapter {
  AirConditionerDetailViewModel fromConfiguration(AirConditionerConfiguration configuration);
  AirConditionerDetailViewModel fromMap(Map<String, dynamic> map);
  Map<String, dynamic> toMap(AirConditionerDetailViewModel viewModel);
}

class AirConditionerDetailViewModelAdapter implements BaseAirConditionerDetailViewModelAdapter {
  AirConditionerDetailViewModel fromConfiguration(AirConditionerConfiguration configuration) {
    if (configuration == null) {
      return null;
    }

    return AirConditionerDetailViewModel(
      id: configuration.id,
      offset: configuration.offset.toDouble(),
      setpoint: configuration.setpoint.toDouble(),
      isOn: configuration.isOn,
      useRemote: configuration.useRemote,
    );
  }

  AirConditionerDetailViewModel fromMap(Map<String, dynamic> map) {
    if (map == null) {
      return null;
    }

    return AirConditionerDetailViewModel(
      id: map['id'],
      isOn: map['isOn'],
      offset: map['offset'],
      setpoint: map['setpoint'],
      useRemote: map['useRemote'],
    );
  }

  Map<String, dynamic> toMap(AirConditionerDetailViewModel viewModel) {
    return {
      'id': viewModel.id,
      'isOn': viewModel.isOn,
      'offset': viewModel.offset,
      'setpoint': viewModel.setpoint,
      'useRemote': viewModel.useRemote,
    };
  }
}
