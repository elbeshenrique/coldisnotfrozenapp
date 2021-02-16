import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_item.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/errors/errors.dart';

abstract class AirConditionerState {}

class StartAirConditionerState implements AirConditionerState {
  const StartAirConditionerState();
}

class LoadingAirConditionerState implements AirConditionerState {
  const LoadingAirConditionerState();
}

class ErrorAirConditionerState implements AirConditionerState {
  final AirConditionerError error;
  const ErrorAirConditionerState(this.error);
}

class SuccessAirConditionerState implements AirConditionerState {
  final List<AirConditionerItem> list;
  const SuccessAirConditionerState(this.list);
}