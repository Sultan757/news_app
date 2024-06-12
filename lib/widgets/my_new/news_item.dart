import 'package:flutter/material.dart';
import 'package:showcase_app/app/app.router.dart';
import 'package:showcase_app/constant/app_colors.dart';
import 'package:showcase_app/constant/font_styles_constant.dart';
import 'package:showcase_app/services/local/navigation_services.dart';
import 'package:showcase_app/utils/size_util.dart';

Widget newsListView(
    {String? img, String? title, String? shortDesc,

      //  String? uploadedTime
    }) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Card(
      elevation: 2.0,
      child: Container(
        height: 140.flexibleHeight,
        width: 100.flexibleWidth,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          children: [
            SizedBox(
              height: 140.flexibleHeight,
              width: 150.flexibleWidth,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  bottomLeft: Radius.circular(12.0),
                ),
                child: Image.network(
                  img!,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(width: 8.flexibleWidth), // Added spacing between image and text
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 6.0,vertical: 8.flexibleHeight),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child: Text(
                          title!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: FontStylesConstant.font16(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryBlack
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          shortDesc!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: FontStylesConstant.font14(color: AppColors.primaryBlack),
                        ),
                      ),
                      SizedBox(height: 16.flexibleHeight),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     // Text(
                      //     //   uploadedTime!,
                      //     //   style: FontStylesConstant.font12(
                      //     //     color: AppColors.grey,
                      //     //   ),
                      //     // ),
                      //     InkWell(
                      //         onTap: (){
                      //           NavService.navigateTo(Routes.subscriptionView);
                      //         },
                      //         child: Icon(Icons.lock, color: AppColors.grey,size: 18.fontSize,))
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

