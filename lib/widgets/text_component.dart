import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:showcase_app/constant/app_colors.dart';

class TextComponent extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final TextStyle? style;
  final TextOverflow? overFlow;
  final int? maxLines;
  final bool? softWrap;
  final double textScaleFactor;
  final List<String> listOfText;
  final List<TextStyle> listOfTextStyle;
  final List<Function()?> listOfOnPressedFunction;
  final bool removeSpace;

  const TextComponent(
      this.text, {
        Key? key,
        this.textAlign = TextAlign.left,
        this.style,
        this.overFlow = TextOverflow.ellipsis,
        this.maxLines,
        this.softWrap,
        this.textScaleFactor = 1.0,
        this.listOfText = const [],
        this.listOfTextStyle = const [],
        this.listOfOnPressedFunction = const [],
        this.removeSpace = false,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (listOfText.isEmpty) {
      return Text(
        text,
        maxLines: maxLines,
        softWrap: softWrap,
        overflow: overFlow,
        textAlign: textAlign,
        style: style,
      );
    } else {
      final listOfTextSpans = <TextSpan>[];
      for (var t = 0; t < listOfText.length; t++) {
        listOfTextSpans.add(
          TextSpan(
            text: '${listOfText[t]}${t < listOfText.length - 1 ? '\n' : ''}',
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                if (t < listOfOnPressedFunction.length) {
                  listOfOnPressedFunction[t]?.call();
                }
              },
            style: t < listOfTextStyle.length
                ? listOfTextStyle[t]
                : const TextStyle(color: AppColors.primaryBlack),
          ),
        );
      }
      return RichText(
        text: TextSpan(children: listOfTextSpans),
      );
    }
  }
}
