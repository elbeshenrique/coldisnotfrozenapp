abstract class AirConditionerConfiguration {
  final String id;
  final double offset;
  final num setpoint;
  final bool isOn;
  final bool useRemote;
  
  const AirConditionerConfiguration({
    this.id,
    this.offset,
    this.setpoint,
    this.isOn,
    this.useRemote,
  });
}
