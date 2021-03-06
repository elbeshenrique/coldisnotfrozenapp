import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:guard_class/app/modules/login/domain/entities/logged_user.dart';
import 'package:guard_class/app/modules/login/domain/errors/errors.dart';
import 'package:guard_class/app/modules/login/external/datasources/firebase_datasource.dart';
import 'package:guard_class/app/modules/login/infra/drivers/google_athenticator_driver.dart';
import 'package:guard_class/app/modules/login/infra/datasources/login_datasource.dart';
import 'package:mockito/mockito.dart';

class LoginDataSourceMock extends Mock implements LoginDataSource {}

class GoogleAuthenticatorDriverMock extends Mock implements GoogleAuthenticatorDriver {}

class UserMock extends Mock implements User {}

class UserCredentialMock extends Mock implements UserCredential {}

class AuthCredentialMock extends Mock implements OAuthCredential {}

class PhoneAuthCredentialMock extends Mock implements PhoneAuthCredential {}

class FirebaseAuthExceptionMock extends Mock implements FirebaseAuthException {}

class FirebaseAuthMock extends Mock implements FirebaseAuth {
  @override
  Future<void> verifyPhoneNumber({
    String phoneNumber,
    PhoneVerificationCompleted verificationCompleted,
    PhoneVerificationFailed verificationFailed,
    PhoneCodeSent codeSent,
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout,
    String autoRetrievedSmsCodeForTesting,
    Duration timeout = const Duration(seconds: 30),
    int forceResendingToken,
  }) async {
    Future.delayed(Duration(seconds: 0)).then((value) {
      if (phoneNumber == "0") {
        verificationCompleted(phoneAuthCredentialMock);
      } else if (phoneNumber == "1") {
        verificationFailed(firebaseAuthExceptionMock);
      } else if (phoneNumber == "2") {
        codeSent("dwf32f", 1);
      } else if (phoneNumber == "3") {
        codeAutoRetrievalTimeout("dwf32f");
        codeSent("dwf32f", 1);
      }
    });
    return;
  }
}

final phoneAuthCredentialMock = PhoneAuthCredentialMock();
final authCredentialMock = AuthCredentialMock();
final firebaseAuthExceptionMock = FirebaseAuthExceptionMock();

main() {
  final googleAuthenticatorMock = GoogleAuthenticatorDriverMock();

  final firebaseAuthMock = FirebaseAuthMock();
  final firebaseUserMock = UserMock();
  final userCredentialMock = UserCredentialMock();

  final String phoneVerificationId = "";
  final String phoneCode = "";

  final loggedUser = const LoggedUser(
    name: "Jacob",
    phoneNumber: "123456",
    email: "jacob@flutterando.com",
  );

  final datasource = FirebaseDataSourceImpl(firebaseAuthMock, googleAuthenticatorMock);

  setUpAll(() {
    when(firebaseUserMock.displayName).thenReturn("Jacob");
    when(firebaseUserMock.email).thenReturn("jacob@flutterando.com");
    when(firebaseUserMock.phoneNumber).thenReturn("123456");

    when(userCredentialMock.user).thenReturn(firebaseUserMock);

    when(googleAuthenticatorMock.getAuthCredential()).thenAnswer((_) async => authCredentialMock);
  });

  group("loginGoogle", () {
    test('should return LoggedUser loginGoogle', () async {
      when(firebaseAuthMock.signInWithCredential(any)).thenAnswer((_) async => userCredentialMock);
      var result = await datasource.loginGoogle();
      expect(result.name, equals(loggedUser.name));
      expect(result.phoneNumber, equals(loggedUser.phoneNumber));
      expect(result.email, equals(loggedUser.email));
    });
    test('should return FirebaseAuthException loginGoogle Error', () async {
      when(firebaseAuthMock.signInWithCredential(any)).thenThrow(firebaseAuthExceptionMock);
      expect(() async => await datasource.loginGoogle(), throwsA(firebaseAuthExceptionMock));
    });
    test('should return UserModel null when login is canceled loginGoogle', () async {
      when(googleAuthenticatorMock.getAuthCredential()).thenReturn(null);
      final result = await datasource.loginGoogle();
      expect(result, equals(null));
    });
  });

  group("loginEmail", () {
    test('should return LoggedUser loginEmail', () async {
      when(firebaseAuthMock.signInWithEmailAndPassword(email: anyNamed('email'), password: anyNamed('password'))).thenAnswer((_) async => userCredentialMock);
      var result = await datasource.loginEmail();
      expect(result.name, equals(loggedUser.name));
      expect(result.phoneNumber, equals(loggedUser.phoneNumber));
      expect(result.email, equals(loggedUser.email));
    });
    test('should return FirebaseAuthException loginEmail Error', () async {
      when(firebaseAuthMock.signInWithEmailAndPassword(email: anyNamed('email'), password: anyNamed('password'))).thenThrow(firebaseAuthExceptionMock);
      expect(() async => await datasource.loginEmail(), throwsA(firebaseAuthExceptionMock));
    });
  });

  group("loginPhone", () {
    test('should return LoggedUser validateCode', () async {
      when(firebaseAuthMock.signInWithCredential(any)).thenAnswer((_) async => userCredentialMock);
      var result = await datasource.validateCode(verificationId: phoneVerificationId, code: phoneCode);
      expect(result.name, equals(loggedUser.name));
      expect(result.phoneNumber, equals(loggedUser.phoneNumber));
      expect(result.email, equals(loggedUser.email));
    });
    test('should return LoggedUser loginPhone', () async {
      when(firebaseAuthMock.signInWithCredential(any)).thenAnswer((_) async => userCredentialMock);
      var result = await datasource.loginPhone(phone: "0");
      expect(result.name, equals(loggedUser.name));
      expect(result.phoneNumber, equals(loggedUser.phoneNumber));
      expect(result.email, equals(loggedUser.email));
    });
    test('should return FirebaseUser loginPhone Error', () async {
      expect(() async => await datasource.loginPhone(phone: "1"), throwsA(firebaseAuthExceptionMock));
    });
    test('should return NotAutomaticRetrieved loginPhone Not Automatic Retrieve', () async {
      expect(() async => await datasource.loginPhone(phone: "3"), throwsA(isA<NotAutomaticRetrieved>()));
    });
  });

  group("currentUser", () {
    test('should return LoggedUser', () async {
      when(firebaseAuthMock.currentUser).thenAnswer((_) => firebaseUserMock);
      var result = await datasource.currentUser();
      expect(result.name, equals(loggedUser.name));
      expect(result.phoneNumber, equals(loggedUser.phoneNumber));
      expect(result.email, equals(loggedUser.email));
    });
    test('should return ErrorGetLoggedUser if User is not logged', () async {
      when(firebaseAuthMock.currentUser).thenAnswer((_) => null);
      expect(datasource.currentUser(), throwsA(isA<ErrorGetLoggedUser>()));
    });
  });

  group("logout", () {
    test('should complete logout', () async {
      when(firebaseAuthMock.signOut()).thenAnswer((_) async {});
      expect(datasource.logout(), completes);
    });
    test('should return error', () async {
      when(firebaseAuthMock.signOut()).thenThrow(Exception());
      expect(datasource.logout(), throwsA(isA<Exception>()));
    });
  });
}
