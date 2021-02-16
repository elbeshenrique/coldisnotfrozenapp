import 'package:dartz/dartz.dart' show Right, Left;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guard_class/app/modules/air_conditioner/air_conditioner_module.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/errors/errors.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/usecases/get_air_conditioner_item_model_list.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/models/air_conditioner_item_model.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/ar_conditioner_store.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/states/air_conditioner_states.dart';
import 'package:mockito/mockito.dart';

class GetAirConditionerItemModelListMock extends Mock implements GetAirConditionerItemModelList {}

main() {
  var getAirConditionerItemModelListMock = GetAirConditionerItemModelListMock();

  initModule(AirConditionerModule(), changeBinds: [
    Bind<GetAirConditionerItemModelList>((i) => getAirConditionerItemModelListMock),
  ]);

  group("getData", () {
    test('should return a SuccessAirConditionerStoreState', () async {
      when(getAirConditionerItemModelListMock.call()).thenAnswer((_) async => Right(<AirConditionerItemModel>[]));
      var store = Modular.get<AirConditionerStore>();
      var result = await store.getData();
      expect(result, isA<SuccessAirConditionerState>());
    });
    test('should return a ErrorAirConditionerState when usecase fails', () async {
      when(getAirConditionerItemModelListMock.call()).thenAnswer((_) async => Left(GetAirConditionerItemModelListError()));
      var store = Modular.get<AirConditionerStore>();
      var result = await store.getData();
      expect(result, isA<ErrorAirConditionerState>());
    });
  });

  group("stateReaction", () {
    test('should change the state to SuccessAirConditionerState', () async {
      when(getAirConditionerItemModelListMock.call()).thenAnswer((_) async => Right(<AirConditionerItemModel>[]));
      var store = Modular.get<AirConditionerStore>();
      await store.stateReaction();
      expect(store.state, isA<SuccessAirConditionerState>());
    });
    test('should change the state to ErrorAirConditionerState when usecase fails', () async {
      when(getAirConditionerItemModelListMock.call()).thenAnswer((_) async => Left(GetAirConditionerItemModelListError()));
      var store = Modular.get<AirConditionerStore>();
      await store.stateReaction();
      expect(store.state, isA<ErrorAirConditionerState>());
    });
  });

  group("loadData", () {
    test('should change the state to SuccessAirConditionerState', () async {
      when(getAirConditionerItemModelListMock.call()).thenAnswer((_) async => Right(<AirConditionerItemModel>[]));
      var store = Modular.get<AirConditionerStore>();
      await store.loadData();
      expect(store.state, isA<SuccessAirConditionerState>());
    });
    test('should change the state to ErrorAirConditionerState when usecase fails', () async {
      when(getAirConditionerItemModelListMock.call()).thenAnswer((_) async => Left(GetAirConditionerItemModelListError()));
      var store = Modular.get<AirConditionerStore>();
      await store.loadData();
      expect(store.state, isA<ErrorAirConditionerState>());
    });
  });
}
