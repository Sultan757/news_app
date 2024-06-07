import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:showcase_app/services/firebase/authentication_service.dart';
import 'package:stacked/stacked.dart';

class ForgotPasswordViewModel extends BaseViewModel {
  TextEditingController emailController = TextEditingController();

  FocusNode  emailFocusNode = FocusNode();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final AuthenticationService _authenticationService = AuthenticationService();

  bool showOtp = false;

  FocusNode otpFocusNode = FocusNode();

  bool isOtpValid = false;

  String generatedOTP = '';

  bool otpRequested = false;

  Future<void> requestOtp() async {
    if (formKey.currentState?.validate() ?? false) {
      generatedOTP = _generateOTP();
      try {
        await _authenticationService.sendOtpToEmail(emailController.text, generatedOTP);
        otpRequested = true;
        showOtp = true;
        notifyListeners();
      } catch (e) {
        print('Error sending OTP to email: $e');
      }
    }
  }

  void updateTextFieldsFilled(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      showOtp = true;
      notifyListeners();
    }
  }

  String _generateOTP() {
    return (1000 + Random().nextInt(9000)).toString();
  }

  // Method to send OTP via email
  Future<void> sendOtpToEmail(String email) async {
    try {
      await _authenticationService.sendOtpToEmail(email, _generateOTP());
    } catch (e) {
      // Handle error
      print('Error sending OTP to email: $e');
    }
  }

  // Method to verify the OTP entered by the user
  Future<bool> verifyOtp(String enteredOtp) async {
    try {
      bool otpVerified = await _authenticationService.verifyOTP(enteredOtp, generatedOTP);
      isOtpValid = otpVerified;
      notifyListeners();
      return otpVerified;
    } catch (e) {
      print('Error verifying OTP: $e');
      return false;
    }
  }

}
