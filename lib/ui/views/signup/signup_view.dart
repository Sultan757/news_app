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
import 'package:showcase_app/ui/views/signup/signup_viewmodel.dart';
import 'package:showcase_app/utils/validation_util.dart';
import 'package:showcase_app/widgets/button_component.dart';
import 'package:showcase_app/widgets/snackbar_component.dart';
import 'package:showcase_app/widgets/svg_icon_component.dart';
import 'package:showcase_app/widgets/text_component.dart';
import 'package:showcase_app/widgets/text_field_component.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => SignUpViewModel(),
      builder: (context, viewModel, child) {
        return SafeArea(
          child: Scaffold(
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
                    padding: EdgeInsets.only(left: 31.w, right: 31.w, top: 43.h),
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
                                SizedBox(height: 40.h),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextComponent(
                                    AppStrings.signUp,
                                    overFlow: TextOverflow.visible,
                                    listOfText: const [
                                      AppStrings.signUp,
                                      AppStrings.signUpPara,
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
                                _buildFormSection(context, viewModel),
                                SizedBox(height: 20.h),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextComponent(
                                        AppStrings.donotHaveAccount,
                                        overFlow: TextOverflow.visible,
                                        style: FontStylesConstant.font14(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(width: 3.w),
                                      InkWell(
                                        onTap: () {
                                          NavService.navigateTo(Routes.loginView);
                                        },
                                        child: TextComponent(
                                          AppStrings.signIn,
                                          overFlow: TextOverflow.visible,
                                          style: FontStylesConstant.font16(
                                            color: AppColors.primaryPinkColor,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        ButtonComponent(
                          AppStrings.signUp,
                          onBtnPressed: () {
                            _showDialog(context, viewModel);
                          },
                        ),
                        SizedBox(height: 10.h)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showDialog(BuildContext context, SignUpViewModel viewModel) async {
    bool isPasswordMatched = _checkPasswords(viewModel);
    if (!isPasswordMatched) {
      ScaffoldMessenger.of(context).showSnackBar(
          _buildSnackBar(
        context,
        AppStrings.passwordDonotMatched,
        AppStrings.unableToVerify2,
        false,
      ));
      return;
    }

    // Showing the Snackbar after verifying passwords
    ScaffoldMessenger.of(context).showSnackBar(
        _buildSnackBar(
      context,
      AppStrings.thankyou,
      AppStrings.accountCreated,
      true,
    ));

    // Sign up the user
    await viewModel.signUp();

    // Check if signup is successful and form is valid
    if (viewModel.isSignUpSuccessful) {
      NavService.navigateTo(Routes.loginView);
    } else {
      print('Fields are empty or signup failed');
      ScaffoldMessenger.of(context).showSnackBar(
          _buildSnackBar(
        context,
        AppStrings.emptyFields,
        AppStrings.fillSignUpFields,
        false,
      ));
    }
  }

  SnackBar _buildSnackBar(BuildContext context, String heading, String content, bool isVerified) {
    return SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: SnackBarComponent(
        heading: heading,
        content: content,
        isVerified: isVerified,
      ),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      duration: const Duration(seconds: 4),
    );
  }

  bool _checkPasswords(SignUpViewModel viewModel) {
    String password = viewModel.passwordController.text;
    String confirmPassword = viewModel.confirmPasswordController.text;

    if (password.isEmpty || confirmPassword.isEmpty) {
      return false;
    }

    return password == confirmPassword;
  }
}

Widget _buildFormSection(BuildContext context, SignUpViewModel viewModel) {
  return Form(
    key: viewModel.formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 23.h),
        TextFieldComponent(
          viewModel.nameController,
          currentFocus: viewModel.nameFocusNode,
          isLabel: true,
          labelText: AppStrings.labelName,
          hintText: AppStrings.hintName,
          prefixWidget: const SvgIconComponent(
            icon: AppImagePaths.vectorProfileIcon,
          ),
          validator: validateName,
        ),
        SizedBox(height: 10.h),
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
        ),
        TextFieldComponent(
          viewModel.passwordController,
          currentFocus: viewModel.passwordFocusNode,
          isLabel: true,
          isPassword: true,
          labelText: AppStrings.labelPassword,
          hintText: AppStrings.hintPassword,
          prefixWidget: const SvgIconComponent(
            icon: AppImagePaths.vectorPasswordIcon,
          ),
        ),
        SizedBox(height: 10.h),
        TextFieldComponent(
          viewModel.confirmPasswordController,
          currentFocus: viewModel.confirmPasswordFocusNode,
          isLabel: true,
          isPassword: true,
          labelText: AppStrings.labelConfirmPassword,
          hintText: AppStrings.hintPassword,
          prefixWidget: const SvgIconComponent(
            icon: AppImagePaths.vectorPasswordIcon,
          ),
        ),

      ],
    ),
  );
}
