import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:guard_class/app/app_widget.dart';
import 'package:guard_class/app/core/stores/ar_conditioner_store.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/usecases/get_air_conditioner_configuration_list.dart';
import 'package:guard_class/app/modules/air_conditioner/external/datasources/air_conditioner_hasura_datasource.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/repositories/air_conditioner_repository_impl.dart';
import 'package:guard_class/app/modules/login/login_module.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'core/pages/spash_screen_page.dart';
import 'core/stores/auth_store.dart';
import 'modules/air_conditioner/utils/json_serializer.dart';
import 'modules/home/home_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        ...LoginModule.export,
        $AuthStore,
        $AirConditionerStore,
        Bind((i) => Dio()),
        Bind((i) => DartJsonMapperSerializer()),
        Bind((i) => GoogleSignIn()),
        Bind((i) => FirebaseAuth.instance),
        Bind((i) => Connectivity()),
        Bind((i) => AirConditionerHasuraDataSource(i())),
        Bind((i) => AirConditionerRepositoryImpl(i())),
        Bind((i) => GetAirConditionerConfigurationListImpl(i())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter("/", child: (_, __) => SplashScreenPage()),
        ModularRouter("/login", module: LoginModule()),
        ModularRouter("/home", module: HomeModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();
}
