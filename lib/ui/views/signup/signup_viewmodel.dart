import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showcase_app/app/app.locator.dart';
import 'package:showcase_app/app/app.router.dart';
import 'package:showcase_app/models/response/register_response.dart';
import 'package:showcase_app/preferences/user_preferences.dart';
import 'package:showcase_app/services/local/navigation_services.dart';
import 'package:showcase_app/services/remote/api_service.dart';
import 'package:stacked/stacked.dart';

class RegisterViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  ApiService apiService = locator<ApiService>();
  bool isLoading = false;


  Future<RegisterResponse> register() async {
    await SharedPreferencesHelper.saveString(
        'username', nameController.text);


    final response = await apiService.register(
      emailController.text,
      passwordController.text,
    );

    if (response.status == 200 || response.status == 201) {
      isLoading = false;
      // saving email
      await SharedPreferencesHelper.saveString(
          'email', '${response.finalUser?.email}');
      //saving register object
      await SharedPreferencesHelper.saveObject<RegisterUser>(
          'registerPayload', response.finalUser!);

      //token
      await SharedPreferencesHelper.saveString('registerToken', response.token!);


      NavService.navigateAndClearStack(Routes.homeView);
      NavService.showSnackBar('Success!', '${response.message}', const Duration(milliseconds: 2000));
      notifyListeners();
    } else {


      NavService.showSnackBar("Registration Fail", "${response.message}",
          const Duration(milliseconds: 2000));
      isLoading = false;
      notifyListeners();
    }

    return response;
  }



}
