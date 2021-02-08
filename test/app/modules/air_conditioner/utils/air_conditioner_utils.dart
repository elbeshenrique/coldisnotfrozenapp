import 'package:guard_class/app/modules/air_conditioner/infra/models/air_conditioner_configuration_model.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/models/air_conditioner_log_model.dart';

final airConditionerConfigurationModelMock = AirConditionerConfigurationModel(
  id: null,
  offset: 0,
  setpoint: 0,
  isOn: false,
  useRemote: true,
);

final airConditionerConfigurationListResponseData = """
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


final airConditionerLogModelMock = AirConditionerLogModel(
  json: "{'localTemperature':0,'remoteTemperature':0,'useRemote':false,'isOn':true,'relayStatus':false,'setpoint':0,'offset':0}",
  createdAt: "2021-02-08"
);

final airConditionerLogListResponseData = """
{
    "data": {
        "airconditioner_log": [
            {
                "created_at": "2021-02-08",
                "json": "{'localTemperature':0,'remoteTemperature':0,'useRemote':false,'isOn':true,'relayStatus':false,'setpoint':0,'offset':0}"
            }
        ]
    }
}
""";
