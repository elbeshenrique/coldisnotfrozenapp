import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:guard_class/app/modules/login/domain/errors/errors.dart';
import 'package:guard_class/app/modules/login/infra/models/user_model.dart';

import '../../infra/datasources/login_datasource.dart';

part 'firebase_datasource.g.dart';

@Injectable(singleton: false)
class FirebaseDataSourceImpl implements LoginDataSource {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  FirebaseDataSourceImpl(this.firebaseAuth, this.googleSignIn);

  @override
  Future<UserModel> loginEmail({String email, String password}) async {
    var userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    var firebaseUser = userCredential.user;
    return UserModel(
      name: firebaseUser.displayName,
      phoneNumber: firebaseUser.phoneNumber,
      email: firebaseUser.email,
    );
  }

  Future<GoogleSignInAccount> _getGoogleSignInAccount() async {
    if (googleSignIn.currentUser != null) {
      return googleSignIn.currentUser;
    }

    return await googleSignIn.signIn();
  }

  Future<GoogleAuthCredential> _getGoogleAuthCredential() async {
    var googleSignInAccount = await _getGoogleSignInAccount();
    var googleSignInAuthentication = await googleSignInAccount.authentication;
    var googleAuthCredential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    return googleAuthCredential;
  }

  @override
  Future<UserModel> loginGoogle() async {
    try {
      var googleAuthCredential = await _getGoogleAuthCredential();
      var userCredential = await firebaseAuth.signInWithCredential(googleAuthCredential);
      var firebaseUser = userCredential.user;
      return UserModel(
        name: firebaseUser.displayName,
        phoneNumber: firebaseUser.phoneNumber,
        email: firebaseUser.email,
      );
    } on Exception catch (ex) {
      throw ErrorLoginGoogle(message: ex.toString());
    }
  }

  @override
  Future<UserModel> loginPhone({String phone}) async {
    var completer = Completer<AuthCredential>();
    await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 30),
        verificationCompleted: (auth) {
          completer.complete(auth);
        },
        verificationFailed: (e) {
          completer.completeError(e);
        },
        codeSent: (String c, [int i]) {
          completer.completeError(NotAutomaticRetrieved(c));
        },
        codeAutoRetrievalTimeout: (v) {});

    var authCredential = await completer.future;
    var userCredential = await firebaseAuth.signInWithCredential(authCredential);
    var firebaseUser = userCredential.user;
    return UserModel(
      name: firebaseUser.displayName,
      phoneNumber: firebaseUser.phoneNumber,
      email: firebaseUser.email,
    );
  }

  @override
  Future<UserModel> validateCode({String verificationId, String code}) async {
    var authCredential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: code);
    var userCredential = await firebaseAuth.signInWithCredential(authCredential);
    var firebaseUser = userCredential.user;
    return UserModel(
      name: firebaseUser.displayName,
      phoneNumber: firebaseUser.phoneNumber,
      email: firebaseUser.email,
    );
  }

  @override
  Future<UserModel> currentUser() async {
    var user = firebaseAuth.currentUser;

    if (user == null) throw ErrorGetLoggedUser();

    return UserModel(
      name: user.displayName,
      phoneNumber: user.phoneNumber,
      email: user.email,
    );
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
    await googleSignIn.disconnect();
  }
}
