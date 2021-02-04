abstract class AirConditionerConfiguration {
  final String id;
  final num offset;
  final num setpoint;
  final bool isOn;
  final bool useRemote;
  
  AirConditionerConfiguration({
    this.id,
    this.offset,
    this.setpoint,
    this.isOn,
    this.useRemote,
  });
}
