import 'package:flutter/material.dart';
import 'package:showcase_app/app/app.router.dart';
import 'package:showcase_app/constant/app_colors.dart';
import 'package:showcase_app/constant/font_styles_constant.dart';
import 'package:showcase_app/services/local/navigation_services.dart';
import 'package:showcase_app/widgets/my_new/news_item.dart';

import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (model) => model.onInit(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: AppColors.frenchSkyBlue,
            iconTheme: const IconThemeData(color: AppColors.white),

            title: Text(
              'News App',
              style: FontStylesConstant.font18(color: AppColors.white),
            ),
          ),
          body:
          // viewModel.isLoading == false
          //     ?
          ListView.builder(
            itemCount: viewModel.imgUrl.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  // if (index == 0 && viewModel.retrieveUserDetails != null && viewModel.retrieveLoginUserDetails != null) {
                  //   NavService.navigateTo(
                  //     Routes.newsDetailsView,
                  //     arguments: NewsDetailsViewArguments(
                  //       newsDetails: viewModel.myData?[index],
                  //     ),
                  //   );
                  // }




                            NavService.navigateTo(
                              Routes.newsDetailsView,
                              // arguments: NewsDetailsViewArguments(
                              //
                              // ),
                            );


                },
                child: newsListView(
                  img: viewModel.imgUrl[index],
                  title: 'dummy news titlle',
                  shortDesc: 'dummy description',
                  //uploadedTime: '20 horas atrás',
                ),
              );
            },
          )
          //     : const Center(
          //   child: CircularProgressIndicator(strokeWidth: 4.0),
          // ),
        );
      },
    );
  }
}
