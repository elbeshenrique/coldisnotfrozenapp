import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/core/stores/ar_conditioner_store.dart';
import 'package:guard_class/app/core/stores/auth_store.dart';

class SplashScreenPage extends StatelessWidget {
  SplashScreenPage() {
    Modular.get<AuthStore>().checkLogin().then((value) {
      Modular.to.pushNamedAndRemoveUntil("/home", (_) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
