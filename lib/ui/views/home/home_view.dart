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

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ResetPasswordViewModel>.reactive(
      viewModelBuilder: () => ResetPasswordViewModel(),
      builder: (context, viewModel, child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.primaryPinkColor,
            body: Column(
              children: [

              ],
            ),
          ),
        );
      },
    );
  }

}
