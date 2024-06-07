import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showcase_app/constant/app_colors.dart';
import 'package:showcase_app/constant/app_images.dart';
import 'package:showcase_app/constant/font_styles_constant.dart';
import 'package:showcase_app/widgets/svg_icon_component.dart';
import 'package:showcase_app/widgets/text_component.dart';

class SnackBarComponent extends StatelessWidget {
  final String heading;
  final String content;
  final bool isVerified;

  const SnackBarComponent({
    Key? key,
    required this.heading,
    required this.content,
    this.isVerified = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w, // Fixed width
      padding: const EdgeInsets.all(16), // Padding
      decoration: BoxDecoration(
        color: const Color(0xFF242C32), // Background color
        borderRadius: BorderRadius.circular(8), // Border radius
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000), // Shadow color with opacity
            blurRadius: 10.0, // Blur radius
            offset: Offset(0, 8), // Shadow position
          ),
          BoxShadow(
            color: Color(0x1F000000), // Shadow color with opacity
            blurRadius: 30.0, // Blur radius
            offset: Offset(0, 6), // Shadow position
          ),
          BoxShadow(
            color: Color(0x24000000), // Shadow color with opacity
            blurRadius: 24.0, // Blur radius
            offset: Offset(0, 16), // Shadow position
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 30.w,
            height: 30.h,
            decoration: BoxDecoration(
                color: AppColors.crayola,
                borderRadius: BorderRadius.circular(15)
            ),
            child: SvgIconComponent(
              icon: isVerified
                  ? AppImagePaths.vectorCheckIcon
                  : AppImagePaths.vectorCrossIcon,
              fit: BoxFit.scaleDown,
            ),
          ),
          SizedBox(width: 16.w), // Gap between the icon and text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextComponent(
                  heading,
                  overFlow: TextOverflow.visible,
                  maxLines: 2,
                  style: FontStylesConstant.font16(
                      fontWeight: FontWeight.w500,
                      color: AppColors.pureWhite
                  ),
                ),
                TextComponent(
                  content,
                  overFlow: TextOverflow.fade,
                  maxLines: 3,
                  style: FontStylesConstant.font12(
                    fontWeight: FontWeight.w300,
                    color: AppColors.silverSand,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

