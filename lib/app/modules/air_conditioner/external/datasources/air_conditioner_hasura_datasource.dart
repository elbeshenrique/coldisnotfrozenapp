import 'package:dio/dio.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_configuration.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/errors/errors.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/datasources/air_conditioner_datasource.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/models/air_conditioner_configuration_model.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/models/air_conditioner_log_model.dart';
import 'package:guard_class/app/modules/air_conditioner/utils/json_serializer.dart';

class AirConditionerHasuraDataSource implements AirConditionerDataSource {
  static const String HASURA_URL = "https://hasura-cold.hasura.app/v1/graphql";
  static const String HASURA_ADMIN_SECRET_KEY = "x-hasura-admin-secret";
  static const String HASURA_ADMIN_SECRET_VALUE = "kVkFOnBfnII8HcGhC7EYSUj7DRM8m4RvxdG3KGRG9jA0sedkAQRVuZLoWTgs1YZF";
  static const String HASURA_QUERY_KEY = "query";
  static const String APPLICATION_JSON = "application/json";

  final Dio dio;
  final BaseJsonSerializer jsonSerializer;

  AirConditionerHasuraDataSource(this.dio, this.jsonSerializer);

  @override
  Future<AirConditionerConfiguration> getConfiguration(String id) async {
    final query = "query MyQuery(\$_eq: uuid = \"$id\"){airconditioner_configuration(where: {id: {_eq: \$_eq}}) {id offset setpoint useRemote isOn }}";
    var response = await dio.post(
      HASURA_URL,
      data: {
        HASURA_QUERY_KEY: query,
      },
      options: Options(
        contentType: APPLICATION_JSON,
        headers: {
          HASURA_ADMIN_SECRET_KEY: HASURA_ADMIN_SECRET_VALUE
        },
      ),
    );

    if (response.statusCode == 200) {
      List<dynamic> airConditionerConfigurationJsonMapList = response.data["data"]["airconditioner_configuration"];
      return _parseConfiguration(airConditionerConfigurationJsonMapList);
    } else {
      throw DatasourceError(message: "Falha ao buscar as configurações.");
    }
  }

  AirConditionerConfigurationModel _parseConfiguration(List<dynamic> jsonList) {
    var list = jsonSerializer.adaptList<AirConditionerConfigurationModel>(jsonList);
    if(list?.length > 0){
      return list[0];
    }

    return null;
  }


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
      List<dynamic> airConditionerConfigurationJsonMapList = response.data["data"]["airconditioner_configuration"];
      return _parseConfigurationList(airConditionerConfigurationJsonMapList);
    } else {
      throw DatasourceError(message: "Falha ao buscar a lista de configurações.");
    }
  }

  List<AirConditionerConfigurationModel> _parseConfigurationList(List<dynamic> jsonMap) {
    var list = jsonSerializer.adaptList<AirConditionerConfigurationModel>(jsonMap);
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
      List<dynamic> airConditionerLogList = response.data["data"]["airconditioner_log"];
      return _parseLastLog(airConditionerLogList);
    } else {
      throw DatasourceError(message: "Falha ao buscar o último histórico de leitura.");
    }
  }

  AirConditionerLogModel _parseLastLog(List<dynamic> airConditionerLogList) {
    if (airConditionerLogList == null || airConditionerLogList.length == 0) {
      return null;
    }

    var airConditionerLogMap = airConditionerLogList[0];
    var airConditionerLogModel = jsonSerializer.adapt<AirConditionerLogModel>(airConditionerLogMap);
    return airConditionerLogModel;
  }

  @override
  Future saveConfiguration(AirConditionerConfiguration airConditionerConfiguration) async {
    final mutation = "mutation MyMutation(\$isOn: Boolean = ${airConditionerConfiguration.isOn}, \$offset: Float = ${airConditionerConfiguration.offset}, \$setpoint: Float = ${airConditionerConfiguration.setpoint}, \$useRemote: Boolean = ${airConditionerConfiguration.useRemote}) { update_airconditioner_configuration_by_pk(pk_columns: {id: \"${airConditionerConfiguration.id}\"}, _set: {isOn: \$isOn, offset: \$offset, setpoint: \$setpoint, useRemote: \$useRemote}) { id }}";
    var response = await dio.post(
      HASURA_URL,
      data: {
        HASURA_QUERY_KEY: mutation
      },
      options: Options(
        contentType: APPLICATION_JSON,
        headers: {
          HASURA_ADMIN_SECRET_KEY: HASURA_ADMIN_SECRET_VALUE
        },
      ),
    );

    if (response.statusCode == 200) {
      String mutationId = response.data["data"]["update_airconditioner_configuration_by_pk"]["id"];
      return mutationId;
    } else {
      throw DatasourceError(message: "Falha ao salvar a configuração de Id ${airConditionerConfiguration.id}.");
    }
  }
}
