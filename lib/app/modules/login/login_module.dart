import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:guard_class/app/modules/login/external/drivers/google_athenticator_driver_impl.dart';
import 'domain/usecases/get_logged_user.dart';
import 'domain/usecases/login_with_email.dart';
import 'domain/usecases/login_with_google.dart';
import 'domain/usecases/login_with_phone.dart';
import 'domain/usecases/logout.dart';
import 'domain/usecases/verify_phone_code.dart';
import 'external/datasources/firebase_datasource.dart';
import 'infra/repositories/login_repository_impl.dart';
import 'infra/services/connectivity_service_impl.dart';
import 'external/drivers/flutter_connectivity_driver_impl.dart';
import 'presenter/pages/login/login_controller.dart';
import 'presenter/pages/login/login_page.dart';
import 'presenter/pages/phone_login/phone_login_controller.dart';
import 'presenter/pages/phone_login/phone_login_page.dart';
import 'presenter/pages/verify_code/verify_code_controller.dart';
import 'presenter/pages/verify_code/verify_code_page.dart';
import 'presenter/utils/loading_dialog.dart';

class LoginModule extends ChildModule {
  static List<Bind> export = [
    Bind((i) => GoogleSignIn()),
    Bind((i) => GoogleAuthenticatorDriverImpl(i())),
    $GetLoggedUserImpl,
    $LogoutImpl,
    $LoginRepositoryImpl,
    $FirebaseDataSourceImpl,
  ];

  @override
  List<Bind> get binds => [
        $VerifyCodeController,
        $LoginController,
        $PhoneLoginController,
        $LoginWithGoogleImpl,
        $LoginWithEmailImpl,
        $VerifyPhoneCodeImpl,
        $LoginWithPhoneImpl,
        $LoadingDialogImpl,
        $ConnectivityServiceImpl,
        $FlutterConnectivityDriver,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter("/", child: (context, args) => LoginPage()),
        ModularRouter("/phone", child: (context, args) => PhoneLoginPage()),
        ModularRouter("/verify/:verificationId", child: (context, args) => VerifyCodePage()),
      ];
}
