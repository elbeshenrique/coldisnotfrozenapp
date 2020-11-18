import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/core/stores/auth_store.dart';
import 'package:guard_class/app/modules/login/domain/entities/logged_user_info.dart';
import 'package:guard_class/app/modules/login/domain/entities/login_credential.dart';
import 'package:guard_class/app/modules/login/domain/usecases/login_with_google.dart';
import 'package:guard_class/app/modules/login/presenter/utils/loading_dialog.dart';
import 'package:mobx/mobx.dart';
import 'package:asuka/asuka.dart' as asuka;

part 'login_controller.g.dart';

@Injectable()
class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final LoginWithGoogle loginWithGoogleUsecase;
  final LoadingDialog loading;
  final AuthStore authStore;

  _LoginControllerBase(this.loginWithGoogleUsecase, this.loading, this.authStore);

  @observable
  String email = "";

  @action
  setEmail(String value) => this.email = value;

  @observable
  String password = "";

  @action
  setPassword(String value) => this.password = value;

  @computed
  LoginCredential get credential => LoginCredential.withEmailAndPassword(email: email, password: password);

  @computed
  bool get isValid => true;

  loginWithGoogle() async {
    loading.show();
    await Future.delayed(Duration(seconds: 1));

    try {
      await loginWithGoogleImplementation();
    } finally {
      await loading.hide();
    }
  }

  Future loginWithGoogleImplementation() async {
    try {
      var result = await loginWithGoogleUsecase();
      result.fold((failure) {
        asuka.showSnackBar(SnackBar(content: Text(failure.message)));
      }, (user) {
        validateLogin(user);
      });
    } catch (ex) {
      throw ex;
    }
  }

  validateLogin(LoggedUserInfo user) {
    authStore.setUser(user);
    if (user == null) {
      return;
    }

    Modular.to.pushReplacementNamed('/home');
  }
}
