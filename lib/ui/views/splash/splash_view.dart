import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showcase_app/app/app.router.dart';
import 'package:showcase_app/constant/app_images.dart';
import 'package:showcase_app/services/local/navigation_services.dart';
import 'package:showcase_app/ui/views/splash/splash_viewmodel.dart';
import 'package:showcase_app/widgets/svg_icon_component.dart';
import 'package:stacked/stacked.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      viewModelBuilder: () => SplashViewModel(),
      builder: (context, viewModel, child) {
        Future.delayed(const Duration(seconds: 2), () {
          NavService.navigateTo(Routes.loginView);
        });
        return Scaffold(
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
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2), // Adjust the sigma values for desired blur intensity
              child: Container(
                color: Colors.black.withOpacity(0.5), // Adjust the opacity as needed
                child: Padding(
                  padding:  EdgeInsets.only(
                      left: 31.h,
                      right: 31.w,
                      top: 53
                  ),
                  child: const Center(
                    child: SvgIconComponent(
                      icon: AppImagePaths.vectorAppIcon,
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
}
