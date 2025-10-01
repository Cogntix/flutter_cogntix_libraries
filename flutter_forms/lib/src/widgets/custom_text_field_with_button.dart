import 'package:flutter/material.dart';
import 'package:flutter_forms/src/themes/default_colors.dart';
import 'package:flutter_forms/src/themes/default_sizes.dart';

class CustomTextFieldWithButton extends StatelessWidget {
  final String? label;
  final TextStyle? labelStyle;
  final String? hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
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

  // Button properties
  final String buttonText;
  final VoidCallback? onButtonPressed;
  final bool isButtonDisabled;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final Color? buttonDisabledColor;
  final Color? buttonDisabledTextColor;
  final TextStyle? buttonTextStyle;

  const CustomTextFieldWithButton({
    Key? key,
    this.label,
    this.labelStyle,
    this.hint,
    this.controller,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
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
    required this.buttonText,
    this.onButtonPressed,
    this.isButtonDisabled = false,
    this.buttonColor,
    this.buttonTextColor,
    this.buttonDisabledColor,
    this.buttonDisabledTextColor,
    this.buttonTextStyle,
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

    // Button colors
    final effectiveButtonColor = buttonColor ?? DefaultColors.focusedBorderColor;
    final effectiveButtonTextColor = buttonTextColor ?? Colors.white;
    final effectiveButtonDisabledColor = buttonDisabledColor ?? Colors.grey[300];
    final effectiveButtonDisabledTextColor = buttonDisabledTextColor ?? Colors.grey[600];

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
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TextField
            Expanded(
              child: TextFormField(
                controller: controller,
                validator: validator,
                keyboardType: keyboardType,
                obscureText: obscureText,
                onChanged: isDisabled ? null : onChanged,
                enabled: !isDisabled,
                style: TextStyle(
                  color: isDisabled
                      ? effectiveDisabledTextColor
                      : effectiveTextColor,
                  fontSize: DefaultSizes.textFontSize,
                ),
                decoration: InputDecoration(
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
                  filled: true,
                  fillColor: isDisabled
                      ? effectiveDisabledBackgroundColor
                      : DefaultColors.backgroundColor,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  // Left side has border radius, right side is flat
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(DefaultSizes.borderRadius),
                      bottomLeft: Radius.circular(DefaultSizes.borderRadius),
                      topRight: Radius.zero,
                      bottomRight: Radius.zero,
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
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(DefaultSizes.borderRadius),
                      bottomLeft: Radius.circular(DefaultSizes.borderRadius),
                      topRight: Radius.zero,
                      bottomRight: Radius.zero,
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
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(DefaultSizes.borderRadius),
                      bottomLeft: Radius.circular(DefaultSizes.borderRadius),
                      topRight: Radius.zero,
                      bottomRight: Radius.zero,
                    ),
                    borderSide: BorderSide(
                      color: effectiveDisabledBorderColor,
                      width: DefaultSizes.normalBorderWidth,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(DefaultSizes.borderRadius),
                      bottomLeft: Radius.circular(DefaultSizes.borderRadius),
                      topRight: Radius.zero,
                      bottomRight: Radius.zero,
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
            ),
            // Button
            Container(
              constraints: const BoxConstraints(
                maxWidth: 100,
              ),
              height: DefaultSizes.fieldHeight,
              child: ElevatedButton(
                onPressed: isButtonDisabled ? null : onButtonPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isButtonDisabled
                      ? effectiveButtonDisabledColor
                      : effectiveButtonColor,
                  foregroundColor: isButtonDisabled
                      ? effectiveButtonDisabledTextColor
                      : effectiveButtonTextColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(DefaultSizes.borderRadius),
                      bottomRight: Radius.circular(DefaultSizes.borderRadius),
                      topLeft: Radius.zero,
                      bottomLeft: Radius.zero,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  elevation: 0,
                  disabledBackgroundColor: effectiveButtonDisabledColor,
                  disabledForegroundColor: effectiveButtonDisabledTextColor,
                ),
                child: Text(
                  buttonText,
                  style: buttonTextStyle ??
                      TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isButtonDisabled
                            ? effectiveButtonDisabledTextColor
                            : effectiveButtonTextColor,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
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