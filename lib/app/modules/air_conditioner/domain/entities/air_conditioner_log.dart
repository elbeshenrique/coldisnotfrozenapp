abstract class AirConditionerLog {
  double get offset;
  int get setpoint;
  bool get isOn;
  bool get useRemote;
  double get localTemperature;
  int get remoteTemperature;
  bool get relayStatus;
  
  String get createdAt;
}
