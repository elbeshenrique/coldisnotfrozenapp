abstract class AirConditionerLogJson {
  final double offset;
  final num setpoint;
  final bool isOn;
  final bool useRemote;
  final double localTemperature;
  final num remoteTemperature;
  final bool relayStatus;

  const AirConditionerLogJson({
    this.offset,
    this.setpoint,
    this.isOn,
    this.useRemote,
    this.localTemperature,
    this.remoteTemperature,
    this.relayStatus,
  });
}
