import 'dart:async';
import 'package:flutter/material.dart';
import 'package:showcase_app/constant/app_colors.dart';
import 'package:showcase_app/constant/font_styles_constant.dart';
import 'package:showcase_app/widgets/text_component.dart';

class TimerButtonComponent extends StatefulWidget {
  final String textAfterTimeExpires;
  final int totalTimeInSec;
  final VoidCallback? onLinkTextAfterTimeExpiresPressed;
  final VoidCallback? onResendOtpPressed;

  const TimerButtonComponent({
    Key? key,
    required this.totalTimeInSec,
    required this.textAfterTimeExpires,
    this.onLinkTextAfterTimeExpiresPressed,
    this.onResendOtpPressed,
  }) : super(key: key);

  @override
  State<TimerButtonComponent> createState() => _TimerButtonComponentState();
}

class _TimerButtonComponentState extends State<TimerButtonComponent> {
  Timer? _timer;
  int _time = 0;
  bool isTimerStart = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isTimerStart) {
      _startTimer();
      isTimerStart = false;
    }
    return InkWell(
      onTap: _time == 0
          ? () {
        isTimerStart = true;
        widget.onResendOtpPressed?.call();
        widget.onLinkTextAfterTimeExpiresPressed?.call();
      }
          : null,
      child: TextComponent(
        _getButtonText(),
        style: FontStylesConstant.font22(
            fontWeight: FontWeight.w600,
            color: AppColors.primaryPinkColor,
            decoration: TextDecoration.underline
        ),
      ),
    );
  }

  String _getButtonText() {
    if (_time > 0) {
      return _getFormattedTime(_time);
    } else {

      return widget.textAfterTimeExpires;
    }
  }

  void _startTimer() {
    _time = widget.totalTimeInSec;
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_time == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _time--;
        });
      }
    });
  }

  String _getFormattedTime(int seconds) {
    final duration = Duration(seconds: seconds);
    var zeroBeforeMinutes = false;
    var zeroBeforeSeconds = false;
    zeroBeforeSeconds = (duration.inSeconds % 60).toString().length == 1;
    zeroBeforeMinutes = duration.inMinutes.toString().length == 1;
    return '${zeroBeforeMinutes ? '0' : ''}${duration.inMinutes}:${zeroBeforeSeconds ? '0' : ''}${duration.inSeconds % 60}';
  }
}
