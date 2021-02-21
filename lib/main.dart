import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dart_json_mapper_mobx/dart_json_mapper_mobx.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:guard_class/app/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/adapters/air_conditioner_detail_view_model_adapter.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/viewmodels/air_conditioner_detail_viewmodel.dart';

import 'main.mapper.g.dart' show initializeJsonMapper;

void main() async {
  initializeJsonMapper(adapters: [mobXAdapter]);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(ModularApp(module: AppModule()));
}
