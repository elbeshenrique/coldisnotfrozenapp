import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guard_class/app/modules/login/domain/errors/errors.dart';
import 'package:guard_class/app/modules/login/domain/repositories/login_repository.dart';
import 'package:guard_class/app/modules/login/domain/services/connectivity_service.dart';
import 'package:guard_class/app/modules/login/domain/usecases/login_with_google.dart';
import 'package:guard_class/app/modules/login/infra/models/user_model.dart';
import 'package:mockito/mockito.dart';

class LoginRepositoryMock extends Mock implements LoginRepository {}

class ConnectivityServiceMock extends Mock implements ConnectivityService {}

class FirebaseUserMock extends Mock implements User {}

main() {
  final loginRepositoryMock = LoginRepositoryMock();
  final connectivityServiceMock = ConnectivityServiceMock();
  final loginWithGoogle = LoginWithGoogleImpl(loginRepositoryMock, connectivityServiceMock);

  setUp(() {
    when(connectivityServiceMock.isOnline()).thenAnswer((_) async => Right(unit));
  });
  test('should consume repository loginGoogle', () async {
    var user = UserModel(name: "null");
    when(loginRepositoryMock.loginGoogle()).thenAnswer((_) async => Right(user));
    var result = await loginWithGoogle();
    expect(result, Right(user));
  });
  test('should return Exception from repository loginGoogle', () async {
    when(loginRepositoryMock.loginGoogle()).thenAnswer((_) async => Left(ErrorLoginGoogle()));
    var result = (await loginWithGoogle()).fold(id, id);
    expect(result, isA<ErrorLoginGoogle>());
  });
  test('should return error when offline', () async {
    when(connectivityServiceMock.isOnline()).thenAnswer((_) async => Left(ConnectionError()));
    var result = (await loginWithGoogle()).fold(id, id);
    expect(result, isA<ConnectionError>());
  });
  test('should return LoggedUserInfo null if login is canceled - loginGoogle', () async {
    when(loginRepositoryMock.loginGoogle()).thenAnswer((_) async => Right(null));
    var result = await loginWithGoogle();
    expect(result | null, equals(null));
  });
}
