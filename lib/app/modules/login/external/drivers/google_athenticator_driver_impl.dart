import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:guard_class/app/modules/login/infra/drivers/google_athenticator_driver.dart';

part 'google_athenticator_driver_impl.g.dart';

@Injectable(singleton: false)
class GoogleAuthenticatorDriverImpl implements GoogleAuthenticatorDriver {
  final GoogleSignIn googleSignIn;

  GoogleAuthenticatorDriverImpl(this.googleSignIn);

  Future<GoogleSignInAccount> _getGoogleSignInAccount() async {
    if (googleSignIn.currentUser != null) {
      return googleSignIn.currentUser;
    }

    return await googleSignIn.signIn();
  }

  Future<OAuthCredential> getAuthCredential() async {
    GoogleSignInAccount googleSignInAccount = await _getGoogleSignInAccount();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    OAuthCredential googleAuthCredential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    return googleAuthCredential;
  }

  Future<GoogleIdentity> disconnect() async {
    return await googleSignIn.disconnect();
  }
}
