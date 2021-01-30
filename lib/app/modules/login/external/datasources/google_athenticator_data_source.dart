import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:guard_class/app/modules/login/infra/datasources/google_athenticator_data_source.dart';

part 'google_athenticator_data_source.g.dart';

@Injectable(singleton: false)
class GoogleAuthenticatorDataSourceImpl implements GoogleAuthenticatorDataSource {
  final GoogleSignIn googleSignIn;

  GoogleAuthenticatorDataSourceImpl(this.googleSignIn);

  Future<GoogleSignInAccount> _getGoogleSignInAccount() async {
    if (googleSignIn.currentUser != null) {
      return googleSignIn.currentUser;
    }

    return await googleSignIn.signIn();
  }

  Future<GoogleAuthCredential> getAuthCredential() async {
    var googleSignInAccount = await _getGoogleSignInAccount();
    var googleSignInAuthentication = await googleSignInAccount.authentication;
    var googleAuthCredential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    return googleAuthCredential;
  }

  Future<void> disconnect() async {
    await googleSignIn.disconnect();
  }
}