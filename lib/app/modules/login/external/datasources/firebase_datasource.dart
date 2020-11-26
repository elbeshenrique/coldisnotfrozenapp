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
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;

  FirebaseDataSourceImpl(this.auth, this.googleSignIn);

  @override
  Future<UserModel> loginEmail({String email, String password}) async {
    var result = await auth.signInWithEmailAndPassword(email: email, password: password);
    var user = result.user;
    return UserModel(
      name: user.displayName,
      phoneNumber: user.phoneNumber,
      email: user.email,
    );
  }

  Future<GoogleSignInAccount> getSignedUserOrSignIn(GoogleSignIn googleSignIn) async {
    final isSignedIn = await googleSignIn.isSignedIn();
    if (!isSignedIn) {
      return await googleSignIn.signIn();
    }

    if (googleSignIn.currentUser != null) {
      return googleSignIn.currentUser;
    }

    return await googleSignIn.signIn();
  }

  @override
  Future<UserModel> loginGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await getSignedUserOrSignIn(googleSignIn);

    if (googleSignInAccount == null) {
      return null;
    }

    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    final AuthCredential authCredential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    UserCredential userCredential;
    try {
      userCredential = await auth.signInWithCredential(authCredential);
    } catch (authResultException) {
      final isSignedIn = await googleSignIn.isSignedIn();
      if (isSignedIn) {
        await googleSignIn.disconnect();
      }

      throw authResultException;
    }

    final User firebaseUser = userCredential.user;

    return UserModel(
      name: firebaseUser.displayName,
      phoneNumber: firebaseUser.phoneNumber,
      email: firebaseUser.email,
    );
  }

  @override
  Future<UserModel> loginPhone({String phone}) async {
    var completer = Completer<AuthCredential>();
    await auth.verifyPhoneNumber(
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

    var credential = await completer.future;
    var user = (await auth.signInWithCredential(credential)).user;
    return UserModel(
      name: user.displayName,
      phoneNumber: user.phoneNumber,
      email: user.email,
    );
  }

  @override
  Future<UserModel> validateCode({String verificationId, String code}) async {
    var _credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: code);
    var user = (await auth.signInWithCredential(_credential)).user;
    return UserModel(
      name: user.displayName,
      phoneNumber: user.phoneNumber,
      email: user.email,
    );
  }

  @override
  Future<UserModel> currentUser() async {
    var user = auth.currentUser;

    if (user == null) throw ErrorGetLoggedUser();

    return UserModel(
      name: user.displayName,
      phoneNumber: user.phoneNumber,
      email: user.email,
    );
  }

  @override
  Future<void> logout() async {
    await auth.signOut();
    await googleSignIn.disconnect();
  }
}
