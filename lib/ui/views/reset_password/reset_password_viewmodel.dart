import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class ResetPasswordViewModel extends BaseViewModel {

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

}
