import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_item.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/errors/errors.dart';

abstract class AirConditionerState {}

class StartState implements AirConditionerState {
  const StartState();
}

class LoadingState implements AirConditionerState {
  const LoadingState();
}

class ErrorState implements AirConditionerState {
  final AirConditionerError error;
  const ErrorState(this.error);
}

class SuccessState implements AirConditionerState {
  final List<AirConditionerItem> list;
  const SuccessState(this.list);
}