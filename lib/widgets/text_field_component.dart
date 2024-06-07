import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:showcase_app/constant/app_colors.dart';
import 'package:showcase_app/constant/font_styles_constant.dart';
import 'package:showcase_app/utils/size_util.dart';
import 'package:showcase_app/widgets/text_component.dart';

class TextFieldComponent extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final bool isPassword;
  final bool isRequired;
  final String? Function(String?)? validator;
  final Function(String _)? onChanged;
  final TextInputType keyboardType;
  final int? maxLength;
  final dynamic suffixIcon;
  final Function()? onSuffixPressed;
  final Widget? prefixWidget;
  final Color? fillColor;
  final bool enlargePrfixWidget;
  final Color labelColor;
  final bool readOnly;
  final bool enabled;
  final int? maxLines;
  final VoidCallback? onTap;
  final FocusNode currentFocus;
  final FocusNode? nextFocus;
  final EdgeInsetsGeometry? padding;
  final bool isLabel;
  final TextStyle? hintTextStyle;
  final TextStyle? textStyle;
  final List<TextInputFormatter>? formatter;
  final TextAlign textAlign;
  final Color focusBorderColor;

  const TextFieldComponent(
      this.controller, {
        Key? key,
        this.hintText,
        this.labelText,
        this.isPassword = false,
        this.isRequired = false,
        this.validator,
        this.onChanged,
        this.keyboardType = TextInputType.text,
        this.maxLength = 45,
        this.suffixIcon,
        this.onSuffixPressed,
        this.prefixWidget,
        this.onTap,
        this.fillColor,
        this.enlargePrfixWidget = true,
        this.labelColor = AppColors.white,
        this.readOnly = false,
        this.enabled = true,
        this.maxLines,
        required this.currentFocus,
        this.nextFocus,
        this.padding,
        this.isLabel = true,
        this.hintTextStyle,
        this.textStyle,
        this.formatter,
        this.textAlign = TextAlign.start,
        this.focusBorderColor = AppColors.white,
      }) : super(key: key);

  @override
  State<TextFieldComponent> createState() => _TextFieldComponentState();
}

class _TextFieldComponentState extends State<TextFieldComponent> {
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return widget.isLabel
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          _showLabelText(),
        4.verticalSizedBox,
        Center(child: textField()),
      ],
    )
        : textField();
  }

  Widget textField() {
    return TextFormField(
      maxLines: widget.maxLines ?? 1,
      controller: widget.controller,
      readOnly: widget.readOnly,
      focusNode: widget.currentFocus,
      cursorColor: AppColors.primaryPinkColor,
      enabled: widget.enabled,
      obscureText: widget.isPassword ? hidePassword : !hidePassword,
      maxLength: widget.maxLength,
      textInputAction: widget.keyboardType == TextInputType.multiline
          ? TextInputAction.newline
          : widget.nextFocus != null
          ? TextInputAction.next
          : TextInputAction.done,
      onTap: widget.onTap,
      onChanged: (_) => widget.onChanged == null ? () {} : widget.onChanged!(_),
      onEditingComplete: () {
        widget.currentFocus.unfocus();
        if (widget.nextFocus != null) {
          widget.nextFocus?.requestFocus();
        }
      },
      style: widget.textStyle ?? FontStylesConstant.font14(),
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.formatter,
      textAlign: widget.textAlign,
      decoration: InputDecoration(
        errorStyle: FontStylesConstant.font12(color: AppColors.redOrange),
        counterText: '',
        filled: true,
        errorMaxLines: 2,
        fillColor: widget.fillColor ?? AppColors.white.withOpacity(0.3),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.lightGrey),
          borderRadius: BorderRadius.circular(8.0), // Adjust the radius as needed
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.lightGrey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.focusBorderColor,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.redOrange),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.redOrange),
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: widget.padding ??
            EdgeInsetsDirectional.only(
                start: 16,
                top: 10,
                bottom: 16,
                end: widget.suffixIcon != null ? 0 : 16),
        border: InputBorder.none,
        hintText: widget.hintText ?? '',
        labelText: widget.labelText,
        labelStyle: FontStylesConstant.font14(
            color: widget.currentFocus.hasFocus
                ? AppColors.black
                : AppColors.lightGrey),
        hintStyle: widget.hintTextStyle ??
            FontStylesConstant.font14(color: AppColors.lightGrey),
        prefixIcon: widget.prefixWidget != null
            ? SizedBox(
          width: widget.enlargePrfixWidget ? 10 : null,
          child: widget.prefixWidget,
        )
            : null,
        suffixIcon: widget.isPassword
            ? GestureDetector(
          child: hidePassword
              ? const Icon(
            Icons.visibility_off,
            color: AppColors.greyishThree,
          )
              : const Icon(
            Icons.visibility,
            color: AppColors.greyishThree,
          ),
          onTap: () {
            setState(() {
              hidePassword = !hidePassword;
            });
          },
        )
            : widget.suffixIcon != null && widget.onSuffixPressed != null
            ? GestureDetector(
          onTap: widget.onSuffixPressed,
          child: widget.suffixIcon.runtimeType == IconData
              ? Icon(
            widget.suffixIcon,
            color: AppColors.greyishThree,
          )
              : widget.suffixIcon,
        )
            : null,
      ),
    );
  }

  Widget _showLabelText() {
    if (widget.labelText != null) {
      return Row(
        children: [
          TextComponent(
            widget.labelText!,
            style: FontStylesConstant.font14(
                color: widget.labelColor, fontWeight: FontWeight.w500),
          ),
          TextComponent(
            widget.isRequired ? '*' : '',
            style: FontStylesConstant.font14(
              color: widget.labelColor,
            ),
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
