import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showcase_app/app/app.router.dart';
import 'package:showcase_app/constant/app_colors.dart';
import 'package:showcase_app/constant/app_images.dart';
import 'package:showcase_app/models/response/login_response.dart';
import 'package:showcase_app/models/response/register_response.dart';
import 'package:showcase_app/preferences/user_preferences.dart';
import 'package:showcase_app/services/local/navigation_services.dart';
import 'package:showcase_app/ui/views/splash/splash_viewmodel.dart';
import 'package:showcase_app/utils/size_util.dart';
import 'package:showcase_app/widgets/svg_icon_component.dart';
import 'package:stacked/stacked.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      viewModelBuilder: () => SplashViewModel(),
      builder: (context, viewModel, child) {

        Future.delayed(const Duration(seconds: 2), () async{
          RegisterUser? registerUser = await SharedPreferencesHelper.getObject<RegisterUser>(
              'registerPayload',
                  (json) => RegisterUser.fromJson(json)
          );
          LoginData? loginUser = await SharedPreferencesHelper.getObject<LoginData>(
              'loginPayload',
                  (json) => LoginData.fromJson(json)
          );
          if(registerUser != null || loginUser != null){
            NavService.navigateTo(Routes.homeView);
          }else{
            NavService.navigateTo(Routes.loginView);

          }
        });
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            color: AppColors.black,
            // decoration: const BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage(AppImagePaths.backgroundImage),
            //     fit: BoxFit.cover,
            //   ),
            // ),
            child: Center(
              child: Image.asset(
               'assets/images/splash.png',
                height: 200.flexibleHeight,
                width: 200.flexibleWidth,
              ),
            ),
          ),
        );
      },
    );
  }
}
