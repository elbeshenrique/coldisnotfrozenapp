abstract class Failure implements Exception {
  String get message;
}

abstract class AirConditionerFailure implements Failure {
}

class DatasourceError extends Failure {
  final String message;
  DatasourceError({this.message});
}