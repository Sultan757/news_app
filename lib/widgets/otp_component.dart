import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:showcase_app/constant/app_colors.dart';
import 'package:showcase_app/constant/app_strings.dart';
import 'package:showcase_app/constant/font_styles_constant.dart';
import 'package:showcase_app/utils/size_util.dart';
import 'package:showcase_app/widgets/text_component.dart';
import 'package:showcase_app/widgets/timer_button_component.dart';


class OtpComponent extends StatelessWidget {
  final void Function(String)? onCompleted;
  final VoidCallback? onTimerExpires;
  final int? totalTimeInSec;
  final TextEditingController controller = TextEditingController();
  final FocusNode? focusNode;
  final VoidCallback? onResendOtp;

  OtpComponent({
    Key? key,
    required this.onCompleted,
    this.onTimerExpires,
    this.totalTimeInSec,
    this.focusNode,
    this.onResendOtp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50.flexibleWidth,
      height: 50.63.flexibleHeight,
      textStyle: FontStylesConstant.font32(
          fontWeight: FontWeight.w500,
          color: AppColors.white.withOpacity(0.7)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.6),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            AppColors.white.withOpacity(0.6),
            AppColors.blackFour.withOpacity(0.9),
          ],
        ),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(
        color: AppColors.primaryPinkColor.withOpacity(0.5),
        width: 1.32.w,
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            AppColors.white.withOpacity(0.7),
            AppColors.blackFour.withOpacity(0.9),
          ],
        ),
      ),
    );

    return Column(
      children: [
        Pinput(
          controller: controller,
          focusNode: focusNode,
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: focusedPinTheme,
          submittedPinTheme: submittedPinTheme,
          validator: (value) {
            return value == '2222' ? null : 'Pin is incorrect';
          },
          pinputAutovalidateMode: PinputAutovalidateMode.disabled,
          showCursor: true,
          onCompleted: onCompleted,
          isCursorAnimationEnabled: true,
          pinAnimationType: PinAnimationType.slide,
        ),
        20.verticalSizedBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextComponent(
              AppStrings.receiveOtp,
              style:FontStylesConstant.font16n(
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
            TimerButtonComponent(
                totalTimeInSec: totalTimeInSec ?? 60,
                textAfterTimeExpires: AppStrings.resendOtp,
                onLinkTextAfterTimeExpiresPressed: () {
                  onTimerExpires?.call();
                  controller.clear();
                },
                onResendOtpPressed: onResendOtp
            )
          ],
        )
      ],
    );
  }
}
