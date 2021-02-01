import 'package:dart_json_mapper/dart_json_mapper.dart';

class JsonUtils {
  static List<T> deserializeListOfMaps<T>(List<Map<String, dynamic>> list) {
    var deserializedModelList = new List<T>();

    for (var item in list) {
      var deserializedModel = JsonMapper.fromMap<T>(item);
      deserializedModelList.add(deserializedModel);
    }

    return deserializedModelList;
  }
}
