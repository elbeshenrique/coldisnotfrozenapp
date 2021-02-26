import 'package:guard_class/app/modules/air_conditioner/domain/errors/errors.dart';

abstract class AirConditionerDetailState {}

class FormAirConditionerDetailState implements AirConditionerDetailState {
  const FormAirConditionerDetailState();
}

class LoadingAirConditionerDetailState implements AirConditionerDetailState {
  const LoadingAirConditionerDetailState();
}

class ErrorAirConditionerDetailState implements AirConditionerDetailState {
  final AirConditionerError error;
  const ErrorAirConditionerDetailState(this.error);
}