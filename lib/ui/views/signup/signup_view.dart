import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:showcase_app/app/app.router.dart';
import 'package:showcase_app/constant/app_colors.dart';
import 'package:showcase_app/constant/font_styles_constant.dart';
import 'package:showcase_app/services/local/navigation_services.dart';
import 'package:showcase_app/ui/views/signup/signup_viewmodel.dart';
import 'package:showcase_app/utils/size_util.dart';
import 'package:showcase_app/widgets/my_new/app_button.dart';
import 'package:showcase_app/widgets/my_new/app_textfield.dart';
import 'package:stacked/stacked.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => RegisterViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              backgroundColor: AppColors.frenchSkyBlue,
              iconTheme: const IconThemeData(color: AppColors.white),
            ),
            body: Padding(
              padding: EdgeInsets.only(
                left: 20.0.flexibleWidth,
                right: 20.0.flexibleWidth,
              ),
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.sizeOf(context).height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10.flexibleHeight,),
                      Image.asset(
                        'assets/images/signup.png',
                        height: 180,
                        width: 180,
                      ),
                      // Text(
                      //   'Sign Up',
                      //   style: FontStylesConstant.font20(
                      //       fontWeight: FontWeight.bold,
                      //       color: AppColors.primaryBlack),
                      // ),
                      const Spacer(),
                      appTextField(
                        // validator: (value) {
                        //   validateName(value);
                        // },
                        hintText: 'Enter your name',
                        prefixIcon: const Icon(
                          Icons.person,
                          color: AppColors.primaryBlack,
                        ),
                      ),
                      SizedBox(height: 10.flexibleHeight),
                      appTextField(
                        controller: viewModel.emailController,
                        hintText: 'Enter your email',
                        prefixIcon: const Icon(
                          Icons.email,
                          color: AppColors.primaryBlack,
                        ),
                      ),
                      SizedBox(height: 10.flexibleHeight),
                      appTextField(
                        controller: viewModel.passwordController,
                        hintText: 'Enter your password',
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: AppColors.primaryBlack,
                        ),
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                      viewModel.isLoading
                          ? const CircularProgressIndicator(
                          color: AppColors.frenchSkyBlue)
                          : appButton(
                          onPressed: () {
                            // if (viewModel.formKey.currentState!.validate()) {
                            //
                            // }
                            viewModel.isLoading = true;
                            viewModel.register();
                            viewModel.notifyListeners();
                          },
                          btnText: viewModel.isLoading
                              ? 'Loading...'
                              : 'Register',
                          bgColor: AppColors.frenchSkyBlue,
                          txtColor: AppColors.white),
                      SizedBox(height: 10.flexibleHeight),
                      Text.rich(TextSpan(
                          text: "Already have an account?",
                          style:
                          FontStylesConstant.font12(color: AppColors.primaryBlack),
                          children: <InlineSpan>[
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    NavService.navigateTo(Routes.loginView);
                                  },
                                text: '  Login here',
                                style: FontStylesConstant.font12(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryBlack))
                          ])),
                      const Spacer(
                        flex: 6,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
