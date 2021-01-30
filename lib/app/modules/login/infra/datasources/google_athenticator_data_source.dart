import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class GoogleAuthenticatorDataSource {
  GoogleSignIn get googleSignIn;
  
  Future<GoogleAuthCredential> getAuthCredential();
  Future<void> disconnect();
}