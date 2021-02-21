abstract class AirConditionerError implements Exception {
  String get message;
}

class DatasourceError extends AirConditionerError {
  final String message;
  DatasourceError({this.message});
}

class RepositoryError extends AirConditionerError {
  final String message;
  RepositoryError({this.message});
}

class GetAirConditionerConfigurationError extends AirConditionerError {
  final String message;
  GetAirConditionerConfigurationError({this.message});
}

class GetAirConditionerConfigurationListError extends AirConditionerError {
  final String message;
  GetAirConditionerConfigurationListError({this.message});
}

class GetAirConditionerItemModelListError extends AirConditionerError {
  final String message;
  GetAirConditionerItemModelListError({this.message});
}

class SaveAirConditionerConfigurationError extends AirConditionerError {
  final String message;
  SaveAirConditionerConfigurationError({this.message});
}