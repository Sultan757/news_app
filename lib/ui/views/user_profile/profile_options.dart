import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showcase_app/utils/size_util.dart';
import 'package:showcase_app/widgets/svg_icon_component.dart';

import '../../../constant/app_colors.dart';
import '../../../constant/app_images.dart';
import '../../../constant/font_styles_constant.dart';
import '../../../widgets/text_component.dart';

class ProfileOption extends StatelessWidget {
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final String title;
  final VoidCallback? onPressed;
  const ProfileOption(
      {super.key,
        required this.prefixIcon,
        this.suffixIcon,
        this.onPressed,
        required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 34.flexibleHeight,
            width: 40.flexibleWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: AppColors.white,
            ),
            child: Icon(
              prefixIcon!,
            ),
          ),
          SizedBox(width: 16.flexibleHeight),
          TextComponent(
            title,
            style: FontStylesConstant.font14(
                fontWeight: FontWeight.w500, color: AppColors.davyGrey),
          ),
          const Spacer(),
          SvgIconComponent(
            icon: AppImagePaths.backgroundImage,
            width: 16.w,
            height: 16.h,
          ),
        ],
      ),
    );
  }
}