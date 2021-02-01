import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dio/dio.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/errors/errors.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/datasources/air_conditioner_datasource.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/models/air_conditioner_configuration_model.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/models/air_conditioner_log_model.dart';
import 'package:guard_class/app/utils/json_serialization_utils.dart';

class AirConditionerHasuraDataSource implements AirConditionerDataSource {
  static const String HASURA_URL = "https://hasura-melon.herokuapp.com/v1/graphql";
  static const String HASURA_ADMIN_SECRET_KEY = "x-hasura-admin-secret";
  static const String HASURA_ADMIN_SECRET_VALUE = "D9rz5x8Se3RjaTzL";
  static const String HASURA_QUERY_KEY = "query";
  static const String APPLICATION_JSON = "application/json";

  final Dio dio;

  AirConditionerHasuraDataSource(this.dio);

  @override
  Future<List<AirConditionerConfigurationModel>> getConfigurationList() async {
    var response = await dio.post(
      HASURA_URL,
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

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> airConditionerConfigurationJsonMapList = response.data["data"]["airconditioner_configuration"];
      return _parseConfigurationList(airConditionerConfigurationJsonMapList);
    } else {
      throw DatasourceError(message: "Falha ao buscar a lista de dados de configuração de dispositivos.");
    }
  }

  List<AirConditionerConfigurationModel> _parseConfigurationList(List<Map<String, dynamic>> jsonMap) {
    var list = JsonUtils.deserializeListOfMaps<AirConditionerConfigurationModel>(jsonMap);
    return list;
  }

  @override
  Future<AirConditionerLogModel> getLastLog(String id) async {
    var response = await dio.post(
      HASURA_URL,
      data: {
        HASURA_QUERY_KEY: "query{airconditioner_log(limit:1,where:{sensor_id:{_eq:\"$id\"}},order_by:{created_at:desc}){created_at,json}}"
      },
      options: Options(
        contentType: APPLICATION_JSON,
        headers: {
          HASURA_ADMIN_SECRET_KEY: HASURA_ADMIN_SECRET_VALUE
        },
      ),
    );

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> airConditionerLogList = response.data["data"]["airconditioner_log"];
      return _parseLastLog(airConditionerLogList);
    } else {
      throw DatasourceError(message: "Falha ao buscar o último histórico de leitura.");
    }
  }

  AirConditionerLogModel _parseLastLog(List<Map<String, dynamic>> airConditionerLogList) {
    if (airConditionerLogList == null || airConditionerLogList.length == 0) {
      return null;
    }

    var airConditionerLogMap = airConditionerLogList[0];
    String airConditionerLogJson = airConditionerLogMap["json"];
    String airConditionerLogCreatedAt = airConditionerLogMap["created_at"];

    var airConditionerLogModel = JsonMapper.deserialize<AirConditionerLogModel>(airConditionerLogJson);
    airConditionerLogModel.createdAt = airConditionerLogCreatedAt;
    return airConditionerLogModel;
  }
}
