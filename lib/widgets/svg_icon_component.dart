import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIconComponent extends StatelessWidget {
  final String icon;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit fit;

  const SvgIconComponent({
    Key? key,
    required this.icon,
    this.height,
    this.width,
    this.color,
    this.fit = BoxFit.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon,
      height: height,
      width: width,
      color: color,
      fit: fit,
    );
  }
}
