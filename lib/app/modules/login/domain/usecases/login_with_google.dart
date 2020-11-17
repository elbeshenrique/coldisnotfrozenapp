import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/modules/login/domain/entities/logged_user_info.dart';
import 'package:guard_class/app/modules/login/domain/errors/errors.dart';

import 'package:guard_class/app/modules/login/domain/repositories/login_repository.dart';
import 'package:guard_class/app/modules/login/domain/services/connectivity_service.dart';

part 'login_with_google.g.dart';

abstract class LoginWithGoogle {
  Future<Either<Failure, LoggedUserInfo>> call();
}

@Injectable(singleton: false)
class LoginWithGoogleImpl implements LoginWithGoogle {
  final LoginRepository repository;
  final ConnectivityService service;

  LoginWithGoogleImpl(this.repository, this.service);

  @override
  Future<Either<Failure, LoggedUserInfo>> call() async {
    var result = await service.isOnline();

    if (result.isLeft()) {
      return result.map((r) => null);
    }

    return await repository.loginGoogle();
  }
}
