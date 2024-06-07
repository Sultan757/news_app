import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' as size;

extension DoubleExtension on num {
  static final size.ScreenUtil _screenUtil = size.ScreenUtil();

  double get flexibleHeight => _screenUtil.setHeight(this);
  double get flexibleWidth => _screenUtil.setWidth(this);
  double get fontSize => _screenUtil.setSp(this);

  /// Use to add horizontal space
  SizedBox get horizontalSizedBox => SizedBox(width: flexibleWidth);

  // Use to add vertical space
  SizedBox get verticalSizedBox => SizedBox(height: flexibleHeight);
}
