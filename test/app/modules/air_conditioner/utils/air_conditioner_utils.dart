import 'package:guard_class/app/modules/air_conditioner/infra/models/air_conditioner_configuration_model.dart';

final airConditionerConfigurationModelMock = AirConditionerConfigurationModel(
  id: null,
  offset: 0,
  setpoint: 0,
  isOn: false,
  useRemote: true,
);

final hasuraResponseData = """
{
    "data": {
        "airconditioner_configuration": [
            {
                "offset": 0.00,
                "setpoint": 0.00,
                "isOn": false,
                "useRemote": true
            }
        ]
    }
}
""";
