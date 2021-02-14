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

class GetAirConditionerItemModelListError extends AirConditionerError {
  final String message;
  GetAirConditionerItemModelListError({this.message});
}