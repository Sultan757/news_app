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
import 'package:showcase_app/ui/views/reset_password/reset_password_viewmodel.dart';
import 'package:showcase_app/widgets/button_component.dart';
import 'package:showcase_app/widgets/snackbar_component.dart';
import 'package:showcase_app/widgets/svg_icon_component.dart';
import 'package:showcase_app/widgets/text_component.dart';
import 'package:showcase_app/widgets/text_field_component.dart';
import 'package:stacked/stacked.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ResetPasswordViewModel>.reactive(
      viewModelBuilder: () => ResetPasswordViewModel(),
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
                                    AppStrings.resetPassword,
                                    overFlow: TextOverflow.visible,
                                    listOfText: const [
                                      AppStrings.resetPassword,
                                      AppStrings.resetPasswordPara,
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
                                          viewModel.passwordController,
                                          currentFocus: viewModel.passwordFocusNode,
                                          nextFocus: viewModel.confirmPasswordFocusNode,
                                          isLabel: true,
                                          isPassword: true,
                                          labelText: AppStrings.labelPassword,
                                          hintText: AppStrings.hintPassword,
                                          prefixWidget: const SvgIconComponent(
                                            icon: AppImagePaths.vectorPasswordIcon,
                                          ),
                                        ),
                                        SizedBox(height: 15.h),
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
                                    )),
                                SizedBox(height: 20.h),

                              ],
                            ),
                          ),
                        ),
                        ButtonComponent(
                            AppStrings.resetPassword,
                            onBtnPressed: () {
                              _showDialog(context, viewModel);
                            }),
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

  void _showDialog(BuildContext context, ResetPasswordViewModel viewModel) {
    bool isPasswordMatched = _checkPasswords(context, viewModel);
    if (isPasswordMatched) {
      const snackBar =  SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: SnackBarComponent(
          heading: AppStrings.thankyou,
          content: AppStrings.passwordReset,
          isVerified: true,
        ),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(left: 15, right: 15, top: 20),
        duration: Duration(seconds: 4),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      NavService.navigateTo(Routes.loginView);
    } else {
      const snackBar = SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: SnackBarComponent(
          heading: AppStrings.passwordDonotMatched,
          content: AppStrings.unableToVerify2,
          isVerified: false,
        ),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(left: 15, right: 15, top: 20),
        duration: Duration(seconds: 4),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  bool _checkPasswords(BuildContext context, ResetPasswordViewModel viewModel) {
    String password = viewModel.passwordController.text;
    String confirmPassword = viewModel.confirmPasswordController.text;

    if (password.isEmpty || confirmPassword.isEmpty) {
      return false;
    }

    if (password != confirmPassword) {
      return false;
    } else {
      return true;
    }
  }


}
