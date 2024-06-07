import 'dart:ui'; // Import dart:ui for ImageFilter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showcase_app/app/app.router.dart';
import 'package:showcase_app/constant/app_colors.dart';
import 'package:showcase_app/constant/app_images.dart';
import 'package:showcase_app/constant/app_strings.dart';
import 'package:showcase_app/constant/font_styles_constant.dart';
import 'package:showcase_app/services/local/navigation_services.dart';
import 'package:showcase_app/ui/views/login/login_viewmodel.dart';
import 'package:showcase_app/utils/validation_util.dart';
import 'package:showcase_app/widgets/button_component.dart';
import 'package:showcase_app/widgets/snackbar_component.dart';
import 'package:showcase_app/widgets/svg_icon_component.dart';
import 'package:showcase_app/widgets/text_component.dart';
import 'package:showcase_app/widgets/text_field_component.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
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
                                    AppStrings.signIn,
                                    overFlow: TextOverflow.visible,
                                    listOfText: const [
                                      AppStrings.signIn,
                                      AppStrings.signInPara,
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
                                        ),
                                        SizedBox(height: 10.h),
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
                                      ],
                                    )),
                                SizedBox(height: 10.h),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () {
                                      NavService.navigateTo(Routes.forgotPasswordView);
                                    },
                                    child: TextComponent(
                                      AppStrings.forgotPassword,
                                      style: FontStylesConstant.font16(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w800
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                const Padding(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgIconComponent(icon: AppImagePaths.vectorFacebookIcon),
                                      SvgIconComponent(icon: AppImagePaths.vectorGoogleIcon),
                                      SvgIconComponent(icon: AppImagePaths.vectorAppleIcon)
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                Padding(
                                  padding: const EdgeInsets.only(left: 30, right: 30),
                                  child: Row(
                                    children: [
                                      TextComponent(
                                        AppStrings.donotHaveAccount,
                                        overFlow: TextOverflow.visible,
                                        style: FontStylesConstant.font14(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w600
                                        ),
                                      ),
                                      SizedBox(width: 3.w,),
                                      InkWell(
                                        onTap: () {
                                          NavService.navigateTo(Routes.signUpView);
                                        },
                                        child: TextComponent(
                                          AppStrings.signUp,
                                          overFlow: TextOverflow.visible,
                                          style: FontStylesConstant.font18(
                                              color: AppColors.primaryPinkColor,
                                              fontWeight: FontWeight.w800
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
                        ButtonComponent(
                          AppStrings.signIn,
                          onBtnPressed: () {
                            _showDialog(context, viewModel);
                          }
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
  void _showDialog(BuildContext context, LoginViewModel viewModel) {
    if (viewModel.formKey.currentState!.validate()) {
      NavService.navigateTo(Routes.homeView);
    } else {
      print('Fields are empty');
      const snackBar = SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: SnackBarComponent(
          heading: AppStrings.emptyFields,
          content: AppStrings.fillLoginFields,
          isVerified: false,
        ),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(left: 15, right: 15, top: 20),
        duration: Duration(seconds: 4),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }


}
