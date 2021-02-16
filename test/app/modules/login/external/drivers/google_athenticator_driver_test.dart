import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:guard_class/app/modules/login/external/drivers/google_athenticator_driver_impl.dart';
import 'package:mockito/mockito.dart';

class GoogleSignInMock extends Mock implements GoogleSignIn {}

class GoogleSignInAccountMock extends Mock implements GoogleSignInAccount {}

class GoogleSignInAuthenticationMock extends Mock implements GoogleSignInAuthentication {}

main() {
  final googleSignInAuthenticationMock = GoogleSignInAuthenticationMock();
  final googleSignInAccountMock = GoogleSignInAccountMock();
  final googleSignInMock = GoogleSignInMock();

  final googleAuthenticatorDataSource = new GoogleAuthenticatorDriverImpl(googleSignInMock);

  setUpAll(() {
    when(googleSignInAuthenticationMock.accessToken).thenReturn("accessToken");
    when(googleSignInAuthenticationMock.idToken).thenReturn("idToken");

    when(googleSignInAccountMock.authentication).thenAnswer((_) async => googleSignInAuthenticationMock);
  });

  group("getAuthCredential", () {
    test("should return GoogleSignInAuthentication getAuthCredential", () async {
      when(googleSignInMock.currentUser).thenReturn(googleSignInAccountMock);

      var result = await googleAuthenticatorDataSource.getAuthCredential();

      expect(result.idToken, equals(googleSignInAuthenticationMock.idToken));
      expect(result.accessToken, equals(googleSignInAuthenticationMock.accessToken));
    });
    test("should return ErrorGoogleCredential getAuthCredential", () async {
      when(googleSignInMock.currentUser).thenReturn(null);
      when(googleSignInMock.signIn()).thenThrow(Exception());
      expect(googleAuthenticatorDataSource.getAuthCredential(), throwsA(isA<Exception>()));
    });
    test("should return LoginCanceledError getAuthCredential", () async {
      when(googleSignInMock.currentUser).thenReturn(null);
      when(googleSignInMock.signIn()).thenReturn(null);
      final result = await googleAuthenticatorDataSource.getAuthCredential();
      expect(result, equals(null));
    });
  });

  group("disconnect", () {
    test("should complete disconnect", () async {
      when(googleSignInMock.disconnect()).thenAnswer((_) async => googleSignInAccountMock);
      var result = googleAuthenticatorDataSource.disconnect();
      expect(result, completes);
    });
    test("should complete disconnect when GoogleSignIn returns null", () async {
      when(googleSignInMock.disconnect()).thenAnswer((_) async => null);
      var result = googleAuthenticatorDataSource.disconnect();
      expect(result, completes);
    });
    test("should return error on disconnect", () async {
      when(googleSignInMock.currentUser).thenReturn(googleSignInAccountMock);
      when(googleSignInMock.disconnect()).thenThrow(new Exception());
      expect(googleAuthenticatorDataSource.disconnect(), throwsA(isA<Exception>()));
    });
    test("should return error on disconnect", () async {
      when(googleSignInMock.currentUser).thenThrow(Exception());
      expect(googleAuthenticatorDataSource.disconnect(), throwsA(isA<Exception>()));
    });
  });
}
