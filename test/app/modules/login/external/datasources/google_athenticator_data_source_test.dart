import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:guard_class/app/modules/login/external/datasources/google_athenticator_data_source.dart';
import 'package:mockito/mockito.dart';

class GoogleSignInMock extends Mock implements GoogleSignIn { }

class GoogleSignInAccountMock extends Mock implements GoogleSignInAccount {}

class GoogleSignInAuthenticationMock extends Mock implements GoogleSignInAuthentication {}

main() {
  final googleSignInAuthenticationMock = GoogleSignInAuthenticationMock();
  final googleSignInAccountMock = GoogleSignInAccountMock();
  final googleSignInMock = GoogleSignInMock();
  
  final googleAuthenticatorDataSource = new GoogleAuthenticatorDataSourceImpl(googleSignInMock);

  setUpAll(() {
    when(googleSignInAuthenticationMock.accessToken).thenReturn("accessToken");
    when(googleSignInAuthenticationMock.idToken).thenReturn("idToken");

    when(googleSignInAccountMock.authentication).thenAnswer((_) async => googleSignInAuthenticationMock);

    when(googleSignInMock.currentUser).thenReturn(googleSignInAccountMock);
    when(googleSignInMock.isSignedIn()).thenAnswer((_) async => true);
  });

  test("should return GoogleSignInAuthentication getGoogleAuthCredential", () async {
    var result = await googleAuthenticatorDataSource.getAuthCredential();
    expect(result.idToken, equals(googleSignInAuthenticationMock.idToken));
    expect(result.accessToken, equals(googleSignInAuthenticationMock.accessToken));
  });  
}
