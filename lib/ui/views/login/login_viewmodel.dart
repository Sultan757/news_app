import 'package:flutter/cupertino.dart';
import 'package:showcase_app/app/app.locator.dart';
import 'package:showcase_app/app/app.router.dart';
import 'package:showcase_app/models/response/login_response.dart';
import 'package:showcase_app/preferences/user_preferences.dart';
import 'package:showcase_app/services/local/navigation_services.dart';
import 'package:showcase_app/services/remote/api_service.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ApiService apiService = locator<ApiService>();

  bool isLoading = false;

  String cat = 'Cat';

  //login api
  Future<LoginResponse> login() async {

    final response = await apiService.login(
      emailController.text,
      passwordController.text,
    );

    if (response.status == 200 || response.status == 201) {
      isLoading = false;
      if(response.data?.profilePicture?.isNotEmpty == true){
        await SharedPreferencesHelper.saveString('profile', response.data!.profilePicture![0].url!);

      }
      // saving email
      await SharedPreferencesHelper.saveString(
          'email', '${response.data?.email}');

      //saving register object
      await SharedPreferencesHelper.saveObject<LoginData>(
          'loginPayload', response.data!);

      //token
      await SharedPreferencesHelper.saveString('token', response.token!);

      NavService.navigateAndClearStack(Routes.homeView);
      NavService.showSnackBar('Success!', '${response.message}', const Duration(milliseconds: 2000));
      notifyListeners();
    } else {


      NavService.showSnackBar("Login Fail", "${response.message}",
          const Duration(milliseconds: 2000));
      isLoading = false;
      notifyListeners();
    }

    return response;
  }
}
