import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:cogntix_flutter_forms/src/themes/default_colors.dart';
import 'package:cogntix_flutter_forms/src/themes/default_sizes.dart';

class CustomPhoneTextFieldWithButton extends StatelessWidget {
  final String? label;
  final TextStyle? labelStyle;
  final PhoneController? controller;
  final String? errorMsg;
  final Color? errorColor;
  final void Function(PhoneNumber?)? onChanged;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? textColor;
  final Color? hintColor;
  final Color? iconColor;
  final bool isDisabled;
  final bool isOptionalMark;
  final bool isCountrySelectionEnabled;
  final Color? disabledBorderColor;
  final Color? disabledTextColor;
  final Color? disabledBackgroundColor;
  final bool shouldFormat;
  final bool showFlagInInput;
  final CountrySelectorNavigator selectorNavigator;

  // Button properties
  final String buttonText;
  final VoidCallback? onButtonPressed;
  final bool isButtonDisabled;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final Color? buttonDisabledColor;
  final Color? buttonDisabledTextColor;
  final TextStyle? buttonTextStyle;

  const CustomPhoneTextFieldWithButton({
    Key? key,
    this.label,
    this.labelStyle,
    this.controller,
    this.errorMsg,
    this.errorColor,
    this.onChanged,
    this.borderColor,
    this.focusedBorderColor,
    this.textColor,
    this.hintColor,
    this.iconColor,
    this.isDisabled = false,
    this.isOptionalMark = false,
    this.isCountrySelectionEnabled = true,
    this.disabledBorderColor,
    this.disabledTextColor,
    this.disabledBackgroundColor,
    this.shouldFormat = true,
    this.showFlagInInput = true,
    this.selectorNavigator = const CountrySelectorNavigator.bottomSheet(),
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
          child: Row(
            children: [
              Text(
                label!,
                style: labelStyle ??
                    TextStyle(
                      color: isDisabled
                          ? effectiveDisabledTextColor
                          : DefaultColors.labelColor,
                      fontSize: DefaultSizes.labelFontSize,
                    ),
              ),
              SizedBox(width: isOptionalMark ? 3 : 0,),
              isOptionalMark ? Text(
                '*',
                style: labelStyle ??
                    TextStyle(
                      color:  DefaultColors.errorTextColor,
                      fontSize: DefaultSizes.labelFontSize,
                    ),
              ): SizedBox(),
            ],
          ),
        )
            : const SizedBox(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Phone Field
            Expanded(
              child: PhoneFormField(
                controller: controller,
                validator: (_) => null,
                isCountrySelectionEnabled: isCountrySelectionEnabled,
                onChanged: isDisabled ? null : onChanged,
                enabled: !isDisabled,
                countrySelectorNavigator: selectorNavigator,
                style: TextStyle(
                  color: isDisabled
                      ? effectiveDisabledTextColor
                      : effectiveTextColor,
                  fontSize: DefaultSizes.textFontSize,
                ),
                decoration: InputDecoration(
                  hintText: 'Enter phone number',
                  hintStyle: TextStyle(
                    color: effectiveHintColor,
                    fontSize: DefaultSizes.hintFontSize,
                  ),
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