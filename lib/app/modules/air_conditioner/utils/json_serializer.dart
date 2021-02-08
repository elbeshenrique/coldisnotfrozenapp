import 'package:dart_json_mapper/dart_json_mapper.dart';

abstract class BaseJsonSerializer {
  T deserialize<T>(String json);
  T adapt<T>(dynamic object);
  List<T> adaptList<T>(List<dynamic> list);
}

class DartJsonMapperSerializer implements BaseJsonSerializer {

  @override
  T deserialize<T>(String json) {
    T deserializedObject = JsonMapper.deserialize<T>(json);
    return deserializedObject;
  }

  @override
  T adapt<T>(dynamic object) {
    T deserializedObject = JsonMapper.fromMap<T>(object);
    return deserializedObject;
  }

  @override
  List<T> adaptList<T>(List<dynamic> list) {
    var deserializedModelList = new List<T>();

    for (var item in list) {
      var deserializedModel = adapt<T>(item);
      deserializedModelList.add(deserializedModel);
    }

    return deserializedModelList;
  }
}
