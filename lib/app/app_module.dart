import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:guard_class/app/app_widget.dart';
import 'package:guard_class/app/core/stores/auth_store.dart';
import 'package:guard_class/app/core/stores/localization_store.dart';
import 'package:guard_class/app/core/stores/theme_store.dart';
import 'package:guard_class/app/modules/air_conditioner/air_conditioner_module.dart';
import 'package:guard_class/app/modules/login/login_module.dart';
import 'package:intl/intl.dart';

import 'core/pages/spash_screen_page.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        ...LoginModule.export,
        Bind<FirebaseAuth>((i) => FirebaseAuth.instance),
        Bind<Connectivity>((i) => Connectivity()),
        $AuthStore,
        Bind<ThemeStore>((i) => ThemeStore()),
        Bind<LocalizationStore>((i) => LocalizationStore()),
        Bind<NumberFormat>((i) {
          final localizationStore = Modular.get<LocalizationStore>();
          return NumberFormat.decimalPattern(localizationStore.deviceLocale.toString());
        }),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, __) => SplashScreenPage()),
        ModularRouter("/login", module: LoginModule()),
        ModularRouter("/air_conditioner", module: AirConditionerModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();
}
