import 'package:dartz/dartz.dart' show Right, Left;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/states/air_conditioner_list_states.dart';
import 'package:mockito/mockito.dart';

import 'package:guard_class/app/modules/air_conditioner/air_conditioner_module.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/errors/errors.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/usecases/get_air_conditioner_item_model_list.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/models/air_conditioner_item_model.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/controllers/ar_conditioner_list_controller.dart';

class GetAirConditionerItemModelListMock extends Mock implements BaseGetAirConditionerItemModelList {}

main() {
  var getAirConditionerItemModelListMock = GetAirConditionerItemModelListMock();

  initModule(AirConditionerModule(), changeBinds: [
    Bind<BaseGetAirConditionerItemModelList>((i) => getAirConditionerItemModelListMock),
  ]);

  group("getData", () {
    test('should return a SuccessAirConditionerStoreState', () async {
      when(getAirConditionerItemModelListMock.call()).thenAnswer((_) async => Right(<AirConditionerItemModel>[]));
      var store = Modular.get<AirConditionerListController>();
      var result = await store.getData();
      expect(result, isA<SuccessAirConditionerListState>());
    });
    test('should return a ErrorAirConditionerState when usecase fails', () async {
      when(getAirConditionerItemModelListMock.call()).thenAnswer((_) async => Left(GetAirConditionerItemModelListError()));
      var store = Modular.get<AirConditionerListController>();
      var result = await store.getData();
      expect(result, isA<ErrorAirConditionerListState>());
    });
  });

  group("stateReaction", () {
    test('should change the state to SuccessAirConditionerState', () async {
      when(getAirConditionerItemModelListMock.call()).thenAnswer((_) async => Right(<AirConditionerItemModel>[]));
      var store = Modular.get<AirConditionerListController>();
      await store.loadData();
      expect(store.state, isA<SuccessAirConditionerListState>());
    });
    test('should change the state to ErrorAirConditionerState when usecase fails', () async {
      when(getAirConditionerItemModelListMock.call()).thenAnswer((_) async => Left(GetAirConditionerItemModelListError()));
      var store = Modular.get<AirConditionerListController>();
      await store.loadData();
      expect(store.state, isA<ErrorAirConditionerListState>());
    });
  });

  group("loadData", () {
    test('should change the state to SuccessAirConditionerState', () async {
      when(getAirConditionerItemModelListMock.call()).thenAnswer((_) async => Right(<AirConditionerItemModel>[]));
      var store = Modular.get<AirConditionerListController>();
      await store.loadData();
      expect(store.state, isA<SuccessAirConditionerListState>());
    });
    test('should change the state to ErrorAirConditionerState when usecase fails', () async {
      when(getAirConditionerItemModelListMock.call()).thenAnswer((_) async => Left(GetAirConditionerItemModelListError()));
      var store = Modular.get<AirConditionerListController>();
      await store.loadData();
      expect(store.state, isA<ErrorAirConditionerListState>());
    });
  });
}
