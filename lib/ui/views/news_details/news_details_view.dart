
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showcase_app/app/app.router.dart';
import 'package:showcase_app/constant/app_colors.dart';
import 'package:showcase_app/constant/font_styles_constant.dart';
import 'package:showcase_app/services/local/navigation_services.dart';
import 'package:showcase_app/utils/size_util.dart';
import 'package:stacked/stacked.dart';

import 'news_details_viewmodel.dart';


class NewsDetailsView extends StatelessWidget {
 // Data? newsDetails;
  int? articleCount;
  String? isVerified;
  List<String> imgUrl = [];
  List<String> imgTitle = [];
  NewsDetailsView({Key? key,

    //this.newsDetails,this.articleCount, this.isVerified

  });

  @override
  Widget build(BuildContext context) {
    // final argData =
    // ModalRoute.of(context)?.settings.arguments as NewsDetailsViewArguments?;
    //
    // // Check if argData is not null
    // if (argData != null) {
    //   // Correctly access the bundleRequest property of argData
    //   newsDetails = argData.newsDetails;
    // }
    // newsDetails?.image?.forEach((element) {
    //   imgUrl.add(element.url!);
    // });


    // newsDetails?.image?.forEach((element) {
    //   imgTitle.add(element.imgTitle ?? '');
    // });
    return ViewModelBuilder<NewsDetailsViewModel>.reactive(
      viewModelBuilder: () => NewsDetailsViewModel(),
      onViewModelReady: (model)=> model.onInit(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(

            centerTitle: true,
            leading: GestureDetector(
                onTap: () {
                  NavService.goBack();
                },
                child:
                const Icon(Icons.arrow_back_ios, color: AppColors.white)),
            backgroundColor: AppColors.frenchSkyBlue,
            iconTheme: const IconThemeData(color: AppColors.white),


            title: Text(
              'News Details',
              style: FontStylesConstant.font18(color: AppColors.white),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.flexibleWidth),

                  child: Container(
                    height: MediaQuery.sizeOf(context).height,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          SizedBox(height: 20.0.flexibleHeight),
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 16.0.flexibleWidth),
                            child: Text(
                              'dummy title',
                              style: FontStylesConstant.font14(
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 1000,
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 7,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                                        child: Text('.................................................',
                                          style: FontStylesConstant.font18(fontWeight: FontWeight.w500, color: AppColors.primaryBlack),
                                        ),
                                      ) ,
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 12),
                                        child: Container(

                                          height: 160.flexibleHeight,
                                          width: MediaQuery.of(context).size.width,

                                          child: Image.network(
                                            'https://media.istockphoto.com/id/1369150014/vector/breaking-news-with-world-map-background-vector.jpg?s=612x612&w=0&k=20&c=9pR2-nDBhb7cOvvZU_VdgkMmPJXrBQ4rB1AkTXxRIKM=',
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'dummy title',
                                        style: FontStylesConstant.font12(
                                            fontWeight: FontWeight.bold,color: AppColors.primaryBlack),
                                        textAlign: TextAlign.center,

                                      ),
                                      SizedBox(height: 20.flexibleHeight,),

                                      Text(
                                        'dummy description',
                                        style: FontStylesConstant.font12(
                                            fontWeight: FontWeight.w400),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  );
                                }),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
