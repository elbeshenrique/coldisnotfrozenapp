import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/adapters/air_conditioner_configuration_adapter.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/states/air_conditioner_detail_states.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/viewmodels/air_conditioner_detail_viewmodel.dart';
import 'package:mobx/mobx.dart';

import 'package:guard_class/app/core/extensions/dartz_extensions.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/usecases/save_air_conditioner_configuration.dart';

part 'ar_conditioner_detail_controller.g.dart';

class AirConditionerDetailController = _AirConditionerDetailControllerBase with _$AirConditionerDetailController;

abstract class _AirConditionerDetailControllerBase with Store {
  final BaseAirConditionerConfigurationAdapter configurationAdapter = Modular.get<BaseAirConditionerConfigurationAdapter>();
  final BaseSaveAirConditionerConfiguration saveAirConditionerConfiguration;

  _AirConditionerDetailControllerBase(this.saveAirConditionerConfiguration);

  @observable
  AirConditionerDetailState state = FormAirConditionerDetailState();

  @action
  setState(AirConditionerDetailState value) => state = value;

  Future save(AirConditionerDetailViewModel detailViewModel) async {
    setState(LoadingAirConditionerDetailState());

    final configuration = configurationAdapter.fromDetailViewModel(detailViewModel);
    final saveConfigurationEither = await saveAirConditionerConfiguration(configuration);
    if (saveConfigurationEither.isLeft()) {
      final error = saveConfigurationEither.getLeft();
      setState(ErrorAirConditionerDetailState(error));
      return;
    }

    final configurationSaved = saveConfigurationEither.getRight();
    Modular.to.pop(configurationSaved);
  }
}
