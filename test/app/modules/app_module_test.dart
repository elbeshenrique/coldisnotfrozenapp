import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dart_json_mapper_mobx/dart_json_mapper_mobx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guard_class/app/app_module.dart';
import 'package:guard_class/app/core/stores/auth_store.dart';
import 'package:guard_class/app/core/stores/theme_store.dart';
import 'package:mockito/mockito.dart';

class FirebaseAuthMock extends Mock implements FirebaseAuth {}

main() async {
  initModule(AppModule(), changeBinds: [
    Bind<FirebaseAuth>((i) => FirebaseAuthMock()),
  ]);

  test("should retrieve AuthStore instance", () {
    final usecase = Modular.get<AuthStore>();
    expect(usecase, isA<AuthStore>());
  });
  test("should retrieve ThemeStore instance", () {
    final usecase = Modular.get<ThemeStore>();
    expect(usecase, isA<ThemeStore>());
  });
}
