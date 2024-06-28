import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:showcase_app/app/app.router.dart';
import 'package:showcase_app/constant/font_styles_constant.dart';
import 'package:showcase_app/preferences/user_preferences.dart';
import 'package:showcase_app/services/local/navigation_services.dart';
import 'package:showcase_app/ui/views/user_profile/profile_viewmodel.dart';
import 'package:showcase_app/utils/size_util.dart';
import 'package:showcase_app/widgets/my_new/app_textfield.dart';
import 'package:showcase_app/widgets/text_component.dart';
import 'package:stacked/stacked.dart';

import '../../../constant/app_colors.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});





  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      onViewModelReady: (viewModel) => viewModel.loadUserData(),
      viewModelBuilder: () => ProfileViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: AppColors.black),
          ),
          backgroundColor: AppColors.pureWhite,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.flexibleWidth),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 22.0),
                    child: Card(
                      color: AppColors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 12, 10, 4),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white54, // Border color
                                    width: 2.0, // Border width
                                  ),
                                ),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    ClipOval(
                                      child: CircleAvatar(
                                        radius: 40
                                            .flexibleWidth, // Adjust radius accordingly
                                        backgroundImage: viewModel.image != null
                                            ?
                                        FileImage(viewModel.image! ): viewModel.existingImage != null ?
                                             NetworkImage(viewModel.existingImage!):

                                        const NetworkImage(
                                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtuphMb4mq-EcVWhMVT8FCkv5dqZGgvn_QiA&s',
                                              ) as ImageProvider,
                                      ),
                                    ),
                                    Positioned(
                                      top: 2,
                                      right: -12,
                                      child: GestureDetector(
                                        onTap: () => viewModel.pickImage(),
                                        child: const CircleAvatar(
                                          radius: 15,
                                          backgroundColor: AppColors.black,
                                          child: Icon(Icons.edit,
                                              color: AppColors.white),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5.flexibleHeight),
                          TextComponent(
                            viewModel.name ?? 'John Doe',
                            style: FontStylesConstant.font16(
                                color: AppColors.white),
                          ),
                          SizedBox(height: 5.flexibleHeight),

                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 21.0.flexibleHeight),
                  appTextField(
                    interactionSelection: false,
                    hintText: viewModel.name,
                    prefixIcon: const Icon(
                      Icons.person,
                      color: AppColors.primaryBlack,
                    ),
                  ),
                  SizedBox(height: 10.flexibleHeight),
                  appTextField(
                    interactionSelection: false,
                    hintText: viewModel.email,
                    prefixIcon: const Icon(
                      Icons.email,
                      color: AppColors.primaryBlack,
                    ),
                  ),
                  SizedBox(
                    height: 20.flexibleHeight,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.black),
                    ),
                    onPressed: () {
                      NavService.navigateAndClearStack(Routes.loginView);
                      SharedPreferencesHelper.removeKey('profile');
                    },
                    child: Text(
                      'Logout',
                      style: FontStylesConstant.font14(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
