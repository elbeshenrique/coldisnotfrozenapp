import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:guard_class/app/core/stores/auth_store.dart';
import 'package:guard_class/app/modules/login/domain/entities/logged_user_info.dart';
import 'package:guard_class/app/modules/login/domain/errors/errors.dart';
import 'package:guard_class/app/modules/login/domain/usecases/get_logged_user.dart';
import 'package:guard_class/app/modules/login/domain/usecases/logout.dart';

class GetLoggedUserMock extends Mock implements GetLoggedUser {}

class LogoutMock extends Mock implements Logout {}

class LoggedUserInfoMock extends Mock implements LoggedUserInfo {}

main() {
  final getLoggedUserMock = GetLoggedUserMock();
  final logoutMock = LogoutMock();
  final loggedUserInfoMock = LoggedUserInfoMock();

  final authStore = AuthStore(getLoggedUserMock, logoutMock);

  group('isLogged', () {
    test('should return true when there is a user logged in', () {
      authStore.setUser(loggedUserInfoMock);
      final result = authStore.isLogged;
      expect(result, true);
    });
    test('should return false when there is no user logged in', () {
      authStore.setUser(null);
      final result = authStore.isLogged;
      expect(result, false);
    });
  });

  group('checkLogin', () {
    test('should return true when there is a user logged in', () async {
      when(getLoggedUserMock.call()).thenAnswer((_) async => Right(loggedUserInfoMock));
      final result = await authStore.checkLogin();
      expect(result, true);
    });
    test('should return false when usecase returns an error', () async {
      when(getLoggedUserMock.call()).thenAnswer((_) async => Left(ErrorGetLoggedUser()));
      final result = await authStore.checkLogin();
      expect(result, false);
    });
  });

  group('singOut', () {
    test('should completes singOut when the usecase returns an unit', () async {
      when(logoutMock.call()).thenAnswer((_) async => Right(unit));
      final result = await authStore.signOut();
      expect(result | null, unit);
    });
    test('should completes singOut when the usecase fails', () async {
      when(logoutMock.call()).thenAnswer((_) async => Left(ErrorGetLoggedUser()));
      final result = await authStore.signOut();
      expect(result.fold(id, id), isA<Failure>());
    });
  });
}
