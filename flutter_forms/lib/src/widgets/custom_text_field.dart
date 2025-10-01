import 'package:flutter/material.dart';
import 'package:flutter_forms/src/themes/default_colors.dart';
import 'package:flutter_forms/src/themes/default_sizes.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final TextStyle? labelStyle;
  final String? hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final InputDecoration? inputDecoration;
  final Widget? suffixIcon;
  final String? errorMsg;
  final Color? errorColor;
  final void Function(String)? onChanged;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? textColor;
  final Color? hintColor;
  final Color? iconColor;
  final bool isDisabled;
  final Color? disabledBorderColor;
  final Color? disabledTextColor;
  final Color? disabledBackgroundColor;

  const CustomTextField({
    Key? key,
    this.label,
    this.labelStyle,
    this.hint,
    this.controller,
    this.validator,
    this.keyboardType,
    this.inputDecoration,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.errorMsg,
    this.errorColor,
    this.onChanged,
    this.borderColor,
    this.focusedBorderColor,
    this.textColor,
    this.hintColor,
    this.iconColor,
    this.isDisabled = false,
    this.disabledBorderColor,
    this.disabledTextColor,
    this.disabledBackgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final effectiveErrorColor = errorColor ?? DefaultColors.errorBorderColor;
    final hasError = errorMsg != null;
    final effectiveBorderColor = borderColor ?? DefaultColors.borderColor;
    final effectiveFocusedBorderColor =
        focusedBorderColor ?? DefaultColors.focusedBorderColor;
    final effectiveTextColor = textColor ?? DefaultColors.textColor;
    final effectiveHintColor = hintColor ?? DefaultColors.hintColor;
    final effectiveIconColor = iconColor ?? DefaultColors.prefixIconColor;
    final effectiveDisabledBorderColor =
        disabledBorderColor ?? DefaultColors.borderColor;
    final effectiveDisabledTextColor =
        disabledTextColor ?? DefaultColors.hintColor;
    final effectiveDisabledBackgroundColor =
        disabledBackgroundColor ?? DefaultColors.disabledBackgroundColor;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null
            ? Padding(
          padding: EdgeInsets.only(
            bottom: DefaultSizes.labelBottomPadding,
          ),
          child: Text(
            label!,
            style: labelStyle ??
                TextStyle(
                  color: isDisabled
                      ? effectiveDisabledTextColor
                      : DefaultColors.labelColor,
                  fontSize: DefaultSizes.labelFontSize,
                ),
          ),
        )
            : const SizedBox(),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          obscureText: obscureText,
          onChanged: isDisabled ? null : onChanged,
          enabled: !isDisabled,
          style: TextStyle(
            color: isDisabled ? effectiveDisabledTextColor : effectiveTextColor,
            fontSize: DefaultSizes.textFontSize,
          ),
          decoration: inputDecoration ??
              InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  color: effectiveHintColor,
                  fontSize: DefaultSizes.hintFontSize,
                ),
                prefixIcon: prefixIcon != null
                    ? IconTheme(
                  data: IconThemeData(
                    color: isDisabled
                        ? effectiveDisabledTextColor
                        : effectiveIconColor,
                    size: DefaultSizes.iconSize,
                  ),
                  child: prefixIcon!,
                )
                    : null,
                suffixIcon: suffixIcon != null
                    ? IconTheme(
                  data: IconThemeData(
                    color: isDisabled
                        ? effectiveDisabledTextColor
                        : effectiveIconColor,
                    size: DefaultSizes.iconSize,
                  ),
                  child: suffixIcon!,
                )
                    : null,
                filled: true,
                fillColor: isDisabled
                    ? effectiveDisabledBackgroundColor
                    : DefaultColors.backgroundColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(DefaultSizes.borderRadius),
                  ),
                  borderSide: hasError
                      ? BorderSide(
                    color: effectiveErrorColor,
                    width: DefaultSizes.normalBorderWidth,
                  )
                      : BorderSide(
                    color: isDisabled
                        ? effectiveDisabledBorderColor
                        : effectiveBorderColor,
                    width: DefaultSizes.normalBorderWidth,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(DefaultSizes.borderRadius),
                  ),
                  borderSide: hasError
                      ? BorderSide(
                    color: effectiveErrorColor,
                    width: DefaultSizes.normalBorderWidth,
                  )
                      : BorderSide(
                    color: effectiveBorderColor,
                    width: DefaultSizes.normalBorderWidth,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(DefaultSizes.borderRadius),
                  ),
                  borderSide: BorderSide(
                    color: effectiveDisabledBorderColor,
                    width: DefaultSizes.normalBorderWidth,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(DefaultSizes.borderRadius),
                  ),
                  borderSide: hasError
                      ? BorderSide(
                    color: effectiveErrorColor,
                    width: DefaultSizes.errorBorderWidth,
                  )
                      : BorderSide(
                    color: effectiveFocusedBorderColor,
                    width: DefaultSizes.focusedBorderWidth,
                  ),
                ),
              ),
        ),
        hasError
            ? Padding(
          padding: EdgeInsets.only(
            top: DefaultSizes.errorTopPadding,
          ),
          child: Text(
            errorMsg!,
            style: TextStyle(
              color: effectiveErrorColor,
              fontSize: DefaultSizes.errorFontSize,
            ),
          ),
        )
            : const SizedBox(),
        SizedBox(height: DefaultSizes.fieldBottomSpacing),
      ],
    );
  }
}