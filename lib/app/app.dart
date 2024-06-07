import 'package:showcase_app/services/remote/api_service.dart';
import 'package:showcase_app/ui/views/forgot_password/forgot_password_view.dart';
import 'package:showcase_app/ui/views/home/home_view.dart';
import 'package:showcase_app/ui/views/login/login_view.dart';
import 'package:showcase_app/ui/views/reset_password/reset_password_view.dart';
import 'package:showcase_app/ui/views/signup/signup_view.dart';
import 'package:showcase_app/ui/views/splash/splash_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashView, initial: true),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: SignUpView),
    MaterialRoute(page: ForgotPasswordView),
    MaterialRoute(page: ResetPasswordView),
    MaterialRoute(page: HomeView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: ApiService),
    LazySingleton(classType: SnackbarService),
  ],
)
class AppSetup {}
