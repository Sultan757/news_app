import 'package:showcase_app/services/remote/api_service.dart';
import 'package:showcase_app/ui/views/home/home_view.dart';
import 'package:showcase_app/ui/views/login/login_view.dart';
import 'package:showcase_app/ui/views/news_details/news_details_view.dart';
import 'package:showcase_app/ui/views/signup/signup_view.dart';
import 'package:showcase_app/ui/views/splash/splash_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashView, initial: true),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: RegisterView),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: NewsDetailsView),

  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: ApiService),
    LazySingleton(classType: SnackbarService),
  ],
)
class AppSetup {}
