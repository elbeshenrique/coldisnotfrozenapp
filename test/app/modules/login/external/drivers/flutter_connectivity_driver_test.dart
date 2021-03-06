import 'package:connectivity/connectivity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guard_class/app/modules/login/external/drivers/flutter_connectivity_driver_impl.dart';
import 'package:mockito/mockito.dart';

class ConnectivityMock extends Mock implements Connectivity {}

main() {
  final connectivity = ConnectivityMock();
  final driver = FlutterConnectivityDriver(connectivity);
  test('should return true mobile isOnline', () async {
    when(connectivity.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.mobile);

    expect(driver.isOnline, completion(true));
  });

  test('should return true wifi isOnline', () async {
    when(connectivity.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.wifi);

    expect(driver.isOnline, completion(true));
  });

  test('should return false isOnline', () async {
    when(connectivity.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.none);

    expect(driver.isOnline, completion(false));
  });

  test('should return Exception isOnline', () async {
    when(connectivity.checkConnectivity()).thenThrow(Exception());

    expect(driver.isOnline, throwsA(isA<Exception>()));
  });
}
