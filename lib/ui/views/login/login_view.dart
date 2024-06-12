import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:showcase_app/app/app.router.dart';
import 'package:showcase_app/constant/app_colors.dart';
import 'package:showcase_app/constant/font_styles_constant.dart';
import 'package:showcase_app/services/local/navigation_services.dart';
import 'package:showcase_app/ui/views/login/login_viewmodel.dart';
import 'package:showcase_app/utils/size_util.dart';
import 'package:showcase_app/utils/validation_util.dart';
import 'package:showcase_app/widgets/my_new/app_button.dart';
import 'package:showcase_app/widgets/my_new/app_textfield.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: AppColors.white,

          appBar: AppBar(
            backgroundColor: AppColors.frenchSkyBlue,
            iconTheme: const IconThemeData(color: AppColors.white),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.flexibleWidth),
            child: Form(
              key: viewModel.formKey,
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.sizeOf(context).height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/images/login.png',
                          height: 220,
                          width: 220,
                        ),
                      ),
                      Text(
                        'Login ',
                        style: FontStylesConstant.font20(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryBlack,
                        ),
                      ),
                      const Spacer(),
                      appTextField(
                        validator: (value) {
                          validateEmail(value);
                        },
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
                      const Spacer(flex: 2),
                      viewModel.isLoading ? const CircularProgressIndicator(color: AppColors.frenchSkyBlue):
                      appButton(
                        onPressed: () {
                          // if (viewModel.formKey.currentState!.validate()) {
                          viewModel.isLoading = true;
                          viewModel.login();
                          viewModel.notifyListeners();

                          //}
                        },
                        btnText:  'Login',
                        bgColor: AppColors.frenchSkyBlue,
                        txtColor: AppColors.white,
                      ),
                      SizedBox(height: 10.flexibleHeight),
                      Text.rich(
                        TextSpan(
                          text: "Dont't have account?",
                          style: FontStylesConstant.font12(
                            color: AppColors.primaryBlack,
                          ),
                          children: <InlineSpan>[
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  NavService.navigateTo(Routes.registerView);
                                },
                              text: '  Register here',
                              style: FontStylesConstant.font12(
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryBlack,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(flex: 4,),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
