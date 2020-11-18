import 'package:dio/dio.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/datasources/air_conditioner_datasource.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/models/air_conditioner_model.dart';

class AirConditionerHasuraDataSource implements AirConditionerDataSource {
  final Dio dio;

  AirConditionerHasuraDataSource(this.dio);

  @override
  Future<AirConditionerModel> getConfig(String id) async {
    var result = await this.dio.post("https://hasura-melon.herokuapp.com/v1/graphql",
        data: {
          "query": "query{airconditioner_configuration(where:{id:{_eq: \"$id\"}}){offset setpoint isOn useRemote}}",
        },
        options: Options(contentType: "application/json", headers: {
          "x-hasura-admin-secret": "D9rz5x8Se3RjaTzL"
        }));
    if (result.statusCode == 200) {
      var mapFirstAirConditioner = result.data["data"]["airconditioner_configuration"][0];
      var airConditionerModel = AirConditionerModel.fromMap(mapFirstAirConditioner);
      return airConditionerModel;
    } else {
      throw Exception();
    }
  }
}
