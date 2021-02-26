import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_item.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/errors/errors.dart';

abstract class AirConditionerListState {}

class StartAirConditionerListState implements AirConditionerListState {
  const StartAirConditionerListState();
}

class LoadingAirConditionerListState implements AirConditionerListState {
  const LoadingAirConditionerListState();
}

class ErrorAirConditionerListState implements AirConditionerListState {
  final AirConditionerError error;
  const ErrorAirConditionerListState(this.error);
}

class SuccessAirConditionerListState implements AirConditionerListState {
  final List<AirConditionerItem> list;
  const SuccessAirConditionerListState(this.list);
}