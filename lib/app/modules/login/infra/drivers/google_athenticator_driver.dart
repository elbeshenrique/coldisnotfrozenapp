import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class GoogleAuthenticatorDriver {  
  Future<OAuthCredential> getAuthCredential();
  Future<GoogleIdentity> disconnect();
}