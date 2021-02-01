abstract class AirConditionerLog {
  final double offset;
  final num setpoint;
  final bool isOn;
  final bool useRemote;
  final double localTemperature;
  final num remoteTemperature;
  final bool relayStatus;
  final String createdAt;

  const AirConditionerLog({
    this.offset,
    this.setpoint,
    this.isOn,
    this.useRemote,
    this.localTemperature,
    this.remoteTemperature,
    this.relayStatus,
    this.createdAt,
  });
}
