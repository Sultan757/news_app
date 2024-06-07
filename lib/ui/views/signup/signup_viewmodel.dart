import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:showcase_app/services/firebase/authentication_service.dart';
import 'package:stacked/stacked.dart';

class SignUpViewModel extends BaseViewModel {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode nameFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final AuthenticationService _authenticationService = AuthenticationService();

  bool _isSignUpSuccessful = false;
  bool get isSignUpSuccessful => _isSignUpSuccessful;

  Future<void> signUp() async {
    if (formKey.currentState!.validate()) {
      try {
        setBusy(true);
        await _authenticationService.signUpWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text,
          name: nameController.text.trim(),
        );
        setBusy(false);
        _isSignUpSuccessful = true;
      } catch (e) {
        setBusy(false);
        _isSignUpSuccessful = false;
      }
    }
  }
}
