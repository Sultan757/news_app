import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends BaseViewModel {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void updateTextFieldsFilled(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();
      notifyListeners();
    }
  }

}
