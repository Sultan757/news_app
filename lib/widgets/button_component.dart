import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showcase_app/constant/app_colors.dart';
import 'package:showcase_app/constant/font_styles_constant.dart';
import 'package:showcase_app/constant/presentation_constant.dart';
import 'package:showcase_app/widgets/svg_icon_component.dart';
import 'package:showcase_app/widgets/text_component.dart';

class ButtonComponent extends StatelessWidget {
  final String btnText;
  final VoidCallback? onBtnPressed;
  final Color btnColor;
  final bool invertBtnColor;
  final bool minimizeSize;
  final String? prefixIcon;
  final String? postfixIcon;
  final Color btnTextColor;
  final List<BoxShadow>? boxShadow;
  final BoxBorder? boxBorder;
  final TextStyle? buttonTextStyle;
  final EdgeInsets padding;
  final double borderRadius;

  const ButtonComponent(
    this.btnText, {
    Key? key,
    required this.onBtnPressed,
    this.btnColor = AppColors.primaryPinkColor,
    this.invertBtnColor = false,
    this.minimizeSize = false,
    this.prefixIcon,
    this.postfixIcon,
    this.btnTextColor = AppColors.white,
    this.boxShadow,
    this.boxBorder,
    this.buttonTextStyle,
    this.padding = const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
    this.borderRadius = PresentationConstant.defaultBorderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _borderRadius = BorderRadius.circular(borderRadius);
    final btnColor = onBtnPressed == null
        ? AppColors.disable
        : invertBtnColor
            ? this.btnColor.withOpacity(PresentationConstant.btnOpacity)
            : this.btnColor;

    final btnTextStyle = buttonTextStyle?.copyWith(
          color: onBtnPressed == null
              ? btnTextColor.withOpacity(0.8)
              : btnTextColor,
        ) ??
        FontStylesConstant.font18(
          fontWeight: FontWeight.bold,
          color: onBtnPressed == null
              ? btnTextColor.withOpacity(0.8)
              : btnTextColor,
        );

    return InkWell(
      onTap: onBtnPressed,
      splashColor: AppColors.greyishThree,
      borderRadius: _borderRadius,
      child: Container(
        constraints: BoxConstraints(minWidth: 132.w),
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: _borderRadius,
          color: btnColor,
          boxShadow: boxShadow,
          border: boxBorder,
        ),
        alignment: minimizeSize ? null : Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: _getRowMainAxisAlignment(),
          children: [
            if (prefixIcon != null) SvgIconComponent(icon: prefixIcon!),
            Flexible(
              child: TextComponent(
                btnText,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: btnTextStyle,
              ),
            ),
            if (postfixIcon != null) SvgIconComponent(icon: postfixIcon!),
          ],
        ),
      ),
    );
  }

  MainAxisAlignment _getRowMainAxisAlignment() {
    return prefixIcon != null || postfixIcon != null
        ? MainAxisAlignment.spaceBetween
        : MainAxisAlignment.center;
  }
}
