import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class GoogleAuthenticatorDriver {
  GoogleSignIn get googleSignIn;
  
  Future<GoogleAuthCredential> getAuthCredential();
  Future<GoogleSignInAccount> disconnect();
}