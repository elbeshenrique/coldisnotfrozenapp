import 'dart:convert';

import 'package:dart_json_mapper/dart_json_mapper.dart';
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
  Future<List<AirConditionerConfigurationModel>> getConfigurationList() async {
    const id = "467683a1-2212-4113-bc05-631d32cde51f";

    var result = await this.dio.post(
          "https://hasura-melon.herokuapp.com/v1/graphql",
          data: {
            HASURA_QUERY_KEY: "query{airconditioner_configuration{id offset setpoint isOn useRemote}}",
          },
          options: Options(
            contentType: APPLICATION_JSON,
            headers: {
              HASURA_ADMIN_SECRET_KEY: HASURA_ADMIN_SECRET_VALUE
            },
          ),
        );

    if (result.statusCode == 200) {
      List<dynamic> airConditionerConfigurationDynamic = result.data["data"]["airconditioner_configuration"];
      var airConditionerConfigurationModelList = new List<AirConditionerConfigurationModel>();

      for (Map<String, dynamic> airConditionerConfigurationMapItem in airConditionerConfigurationDynamic) {
        var airConditionerModel = JsonMapper.deserialize<AirConditionerConfigurationModel>(airConditionerConfigurationMapItem);
        airConditionerConfigurationModelList.add(airConditionerModel);
      }

      return airConditionerConfigurationModelList;
    } else {
      throw Exception();
    }
  }

  @override
  Future<AirConditionerLogModel> getLastLog(String id) async {
    var result = await this.dio.post(
          "https://hasura-melon.herokuapp.com/v1/graphql",
          data: {
            HASURA_QUERY_KEY: "query{airconditioner_log(limit: 1, where:{ sensor_id:{ _eq: \"$id\"}}, order_by: {created_at: desc}) { created_at, json }}"
          },
          options: Options(
            contentType: APPLICATION_JSON,
            headers: {
              HASURA_ADMIN_SECRET_KEY: HASURA_ADMIN_SECRET_VALUE
            },
          ),
        );

    if (result.statusCode == 200) {
      List<dynamic> airConditionerLogList = result.data["data"]["airconditioner_log"];
      if (airConditionerLogList?.length > 0) {
        var airConditionerLogMap = airConditionerLogList[0];
        var airConditionerLogJson = airConditionerLogMap["json"];
        String airConditionerLogCreatedAt = airConditionerLogMap["created_at"];
        
        var airConditionerLogModel = JsonMapper.deserialize<AirConditionerLogModel>(airConditionerLogJson);
        airConditionerLogModel.createdAt = airConditionerLogCreatedAt;
        return airConditionerLogModel;
      }

      return null;
    } else {
      throw Exception();
    }
  }
}
