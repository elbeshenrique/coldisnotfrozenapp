abstract class AirConditionerJsonLog {
  final double offset;
  final num setpoint;
  final bool isOn;
  final bool useRemote;
  final double localTemperature;
  final num remoteTemperature;
  final bool relayStatus;

  const AirConditionerJsonLog({
    this.offset,
    this.setpoint,
    this.isOn,
    this.useRemote,
    this.localTemperature,
    this.remoteTemperature,
    this.relayStatus,
  });
}
