import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dart_json_mapper_mobx/dart_json_mapper_mobx.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:guard_class/app/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'main.mapper.g.dart' show initializeJsonMapper;

void main() async {
  initializeJsonMapper();
  JsonMapper().useAdapter(mobXAdapter);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(ModularApp(module: AppModule()));
}
