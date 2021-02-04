abstract class AirConditionerFailure implements Exception {
  String get message;
}

class DatasourceError extends AirConditionerFailure {
  final String message;
  DatasourceError({this.message});
}

class RepositoryError extends AirConditionerFailure {
  final String message;
  RepositoryError({this.message});
}