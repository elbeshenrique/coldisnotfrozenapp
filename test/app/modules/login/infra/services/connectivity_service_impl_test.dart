import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guard_class/app/modules/login/domain/errors/errors.dart';
import 'package:guard_class/app/modules/login/infra/drivers/connectivity_driver.dart';
import 'package:guard_class/app/modules/login/infra/services/connectivity_service_impl.dart';
import 'package:mockito/mockito.dart';

class ConnectivityDriverMock extends Mock implements ConnectivityDriver {}

main() {
  final driver = ConnectivityDriverMock();
  final service = ConnectivityServiceImpl(driver);

  group("ConnectivityServiceImpl", () {
    test('should return true if has connectivity', () async {
      when(driver.isOnline).thenAnswer((_) async => true);
      var result = await service.isOnline();
      expect(result | null, unit);
    });
    test('should return false if has no connectivity', () async {
      when(driver.isOnline).thenAnswer((_) async => false);
      var result = await service.isOnline();
      expect(result.fold(id, id), isA<ConnectionError>());
    });
    test('should return ConnectionError if the ConnectivityDriver fails', () async {
      when(driver.isOnline).thenThrow(Exception());
      var result = await service.isOnline();
      expect(result.fold(id, id), isA<ConnectionError>());
    });
  });
}
