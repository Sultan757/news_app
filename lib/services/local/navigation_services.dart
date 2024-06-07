import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.locator.dart';

class NavService extends BaseViewModel {
  static final NavigationService _navigationService =
  locator<NavigationService>();

  static final SnackbarService _snackBarService = locator<SnackbarService>();

  static Future<dynamic>? showSnackBar(
      String title, String message, Duration duration) {
    _snackBarService.showSnackbar(
        title: title, message: message, duration: duration);
  }

  static Future<dynamic>? navigateTo(String route, {dynamic arguments}) =>
      _navigationService.navigateTo(route, arguments: arguments);

  static Future<dynamic>? navigateAndClearStack(String route, {dynamic arguments}) =>
      _navigationService.clearStackAndShow(route, arguments: arguments);

  static goBack() => _navigationService.back();
}
