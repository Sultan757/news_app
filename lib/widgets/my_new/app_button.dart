import 'package:flutter/material.dart';
import 'package:showcase_app/constant/app_colors.dart';
import 'package:showcase_app/constant/font_styles_constant.dart';
import 'package:showcase_app/utils/size_util.dart';

Widget appButton({
  required String btnText,
  double? height,
  double? width,
  TextStyle? style,
  Color? bgColor,
  Color? txtColor,
  FontWeight? fontWeight,
  bool isOutline = false,
  Function()? onPressed,
  bool? isPrefixShow = false,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      decoration: BoxDecoration(
          border: isOutline
              ? Border.all(color: AppColors.white)
              : Border.all(color: AppColors.transparent),
          color: bgColor,
          borderRadius: BorderRadius.circular(40.0)),
      height: height ?? 50.0.flexibleHeight,
      width: width ?? 340.0.flexibleWidth,
      child: isPrefixShow == true ? Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2,),
          SizedBox(
              height: 20.flexibleHeight,
              width: 20.flexibleWidth,
              child: Image.asset('assets/icons/gmail.png')),
          const Spacer(),
          Center(
              child: Text(
                btnText,
                style: FontStylesConstant.font14(
                    fontWeight: fontWeight ?? FontWeight.bold,
                    color: txtColor ?? AppColors.white),
              )),
          const Spacer(flex: 3,)
        ],
      ):   Center(
          child: Text(
            btnText,
            style: FontStylesConstant.font14(
                fontWeight: fontWeight ?? FontWeight.bold,
                color: txtColor ?? AppColors.white),
          )),
    ),
  );
}
