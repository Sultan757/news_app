import 'package:flutter/material.dart';
import 'package:showcase_app/constant/app_colors.dart';
import 'package:showcase_app/constant/font_styles_constant.dart';

Widget appTextField({height,width,Icon? prefixIcon, String? hintText, validator, TextEditingController? controller}) {
  return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: AppColors.white,
          border: Border.all(color: AppColors.primaryBlack)
      ),
      child: TextFormField(
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: FontStylesConstant.font14(),
          border: InputBorder.none,
          prefixIcon: prefixIcon,
        ),
      ));
}
