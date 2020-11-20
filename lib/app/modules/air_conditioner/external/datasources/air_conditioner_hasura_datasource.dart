import 'package:dio/dio.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/datasources/air_conditioner_datasource.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/models/air_conditioner_configuration_model.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/models/air_conditioner_log_model.dart';

class AirConditionerHasuraDataSource implements AirConditionerDataSource {
  final String HASURA_ADMIN_SECRET_KEY = "x-hasura-admin-secret";
  final String HASURA_ADMIN_SECRET_VALUE = "D9rz5x8Se3RjaTzL";
  final String HASURA_QUERY_KEY = "query";
  final String APPLICATION_JSON = "application/json";

  final Dio dio;

  AirConditionerHasuraDataSource(this.dio);

  @override
  Future<AirConditionerConfigurationModel> getConfig(String id) async {
    var result = await this.dio.post(
          "https://hasura-melon.herokuapp.com/v1/graphql",
          data: {
            HASURA_QUERY_KEY: "query{airconditioner_configuration(where:{id:{_eq: \"$id\"}}){offset setpoint isOn useRemote}}",
          },
          options: Options(
            contentType: APPLICATION_JSON,
            headers: {
              HASURA_ADMIN_SECRET_KEY: HASURA_ADMIN_SECRET_VALUE
            },
          ),
        );
    if (result.statusCode == 200) {
      var mapFirstAirConditioner = result.data["data"]["airconditioner_configuration"][0];
      var airConditionerModel = AirConditionerConfigurationModel.fromMap(mapFirstAirConditioner);
      return airConditionerModel;
    } else {
      throw Exception();
    }
  }

  @override
  Future<AirConditionerLogModel> getLog(String id) async {
    var result = await this.dio.post(
          "https://hasura-melon.herokuapp.com/v1/graphql",
          data: {
            HASURA_QUERY_KEY: "query{airconditioner_log(limit: 1, where:{id:{_eq: \"$id\"}}, order_by: {created_at: desc}) { json }}"
          },
          options: Options(
            contentType: APPLICATION_JSON,
            headers: {
              HASURA_ADMIN_SECRET_KEY: HASURA_ADMIN_SECRET_VALUE
            },
          ),
        );
    if (result.statusCode == 200) {
      var mapFirstAirConditioner = result.data["data"]["airconditioner_log"][0];
      var airConditionerModel = AirConditionerLogModel.fromMap(mapFirstAirConditioner);
      return airConditionerModel;
    } else {
      throw Exception();
    }
  }
}
