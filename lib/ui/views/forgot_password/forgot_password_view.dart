import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showcase_app/app/app.router.dart';
import 'package:showcase_app/constant/app_colors.dart';
import 'package:showcase_app/constant/app_images.dart';
import 'package:showcase_app/constant/app_strings.dart';
import 'package:showcase_app/constant/font_styles_constant.dart';
import 'package:showcase_app/services/local/navigation_services.dart';
import 'package:showcase_app/ui/views/forgot_password/forgot_password_viewmodel.dart';
import 'package:showcase_app/utils/validation_util.dart';
import 'package:showcase_app/widgets/button_component.dart';
import 'package:showcase_app/widgets/otp_component.dart';
import 'package:showcase_app/widgets/snackbar_component.dart';
import 'package:showcase_app/widgets/svg_icon_component.dart';
import 'package:showcase_app/widgets/text_component.dart';
import 'package:showcase_app/widgets/text_field_component.dart';
import 'package:stacked/stacked.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ForgotPasswordViewModel>.reactive(
      viewModelBuilder: () => ForgotPasswordViewModel(),
      builder: (context, viewModel, child) {
        return SafeArea(
          child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImagePaths.backgroundImage),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Container(
                color: AppColors.black.withOpacity(0.5),
                child: Padding(
                  padding:  EdgeInsets.only(left: 31.h, right: 31.w, top: 53),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Align(
                                alignment: Alignment.center,
                                child: SvgIconComponent(
                                  icon: AppImagePaths.vectorAppIcon,
                                ),
                              ),
                              SizedBox(height: 40.h,),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: TextComponent(
                                  AppStrings.forgotPassword,
                                  overFlow: TextOverflow.visible,
                                  listOfText: const [
                                    AppStrings.forgotPassword,
                                    AppStrings.forgotPasswordPara,
                                  ],
                                  listOfTextStyle: [
                                    FontStylesConstant.font32(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.white,
                                    ),
                                    FontStylesConstant.font16(
                                      fontWeight: FontWeight.w300,
                                      color: AppColors.white,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 23.h),
                              Form(
                                  key: viewModel.formKey,
                                  child: Column(
                                    children: [
                                      TextFieldComponent(
                                        viewModel.emailController,
                                        currentFocus: viewModel.emailFocusNode,
                                        isLabel: true,
                                        labelText: AppStrings.labelEmail,
                                        hintText: AppStrings.hintEmail,
                                        prefixWidget: const SvgIconComponent(
                                          icon: AppImagePaths.vectorMailIcon,
                                        ),
                                        keyboardType: TextInputType.emailAddress,
                                        validator: (value) => validateEmail(value),
                                        onChanged: (_) => viewModel.updateTextFieldsFilled(context),
                                      ),
                                      SizedBox(height: 10.h),
                                    ],
                                  )
                              ),
                              SizedBox(height: 20.h),
                              if (viewModel.showOtp == true)
                                _showOtpView(viewModel, context),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h)
                    ],
                  ),

                ),
              ),
            ),
          ),
        ));
      },
    );
  }
  Widget _showOtpView(ForgotPasswordViewModel viewModel, BuildContext context) {
    if (!viewModel.otpRequested) {
      viewModel.requestOtp();
    }
    if (viewModel.showOtp) {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 14.h),
            child: TextComponent(
              AppStrings.enterOtp,
              overFlow: TextOverflow.visible,
              style: FontStylesConstant.font16(color: AppColors.white),
            ),
          ),
          OtpComponent(
            onCompleted: (pin) async {
              bool otpVerified = await viewModel.verifyOtp(pin);
              if (otpVerified) {
                viewModel.isOtpValid = true;
                NavService.navigateTo(Routes.resetPasswordView);
                showCustomSnackBar(context, true);
              } else {
                viewModel.isOtpValid = false;
                showCustomSnackBar(context, false);
              }
            },
            onTimerExpires: () {
              // Handle timer expiration if needed
            },
            totalTimeInSec: 10,
            focusNode: viewModel.otpFocusNode,
            onResendOtp: () {
              viewModel.requestOtp(); // Only request OTP when needed
            },
          ),
        ],
      );
    } else {
      return SizedBox.shrink();
    }
  }

  void showCustomSnackBar(BuildContext context, bool isOtpVerified) {
    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: SnackBarComponent(
        heading: isOtpVerified
            ? AppStrings.otpVerified
            : AppStrings.verificationFailed,
        content: isOtpVerified
            ? AppStrings.numberVerified
            : AppStrings.unableToVerify,
        isVerified: isOtpVerified,
      ),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
      duration: const Duration(seconds: 4),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
