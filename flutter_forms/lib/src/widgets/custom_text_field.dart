import 'package:flutter/material.dart';
import 'package:flutter_forms/src/themes/default_colors.dart';
import 'package:flutter_forms/src/themes/default_sizes.dart';

class CustomTextField extends StatefulWidget {
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
  final bool isOptionalMark;
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
    this.isOptionalMark = false,
    this.disabledBorderColor,
    this.disabledTextColor,
    this.disabledBackgroundColor,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  void didUpdateWidget(CustomTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.obscureText != oldWidget.obscureText) {
      _isObscured = widget.obscureText;
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    final effectiveErrorColor = widget.errorColor ?? DefaultColors.errorBorderColor;
    final hasError = widget.errorMsg != null;
    final effectiveBorderColor = widget.borderColor ?? DefaultColors.borderColor;
    final effectiveFocusedBorderColor =
        widget.focusedBorderColor ?? DefaultColors.focusedBorderColor;
    final effectiveTextColor = widget.textColor ?? DefaultColors.textColor;
    final effectiveHintColor = widget.hintColor ?? DefaultColors.hintColor;
    final effectiveIconColor = widget.iconColor ?? DefaultColors.prefixIconColor;
    final effectiveDisabledBorderColor =
        widget.disabledBorderColor ?? DefaultColors.borderColor;
    final effectiveDisabledTextColor =
        widget.disabledTextColor ?? DefaultColors.hintColor;
    final effectiveDisabledBackgroundColor =
        widget.disabledBackgroundColor ?? DefaultColors.disabledBackgroundColor;

    Widget? effectiveSuffixIcon = widget.suffixIcon;
    if (widget.obscureText) {
      effectiveSuffixIcon = IconButton(
        icon: Icon(
          _isObscured ? Icons.visibility_off : Icons.visibility,
          color: widget.isDisabled
              ? effectiveDisabledTextColor
              : effectiveIconColor,
          size: DefaultSizes.iconSize,
        ),
        onPressed: widget.isDisabled ? null : _togglePasswordVisibility,
      );
    } else if (widget.suffixIcon != null) {
      effectiveSuffixIcon = IconTheme(
        data: IconThemeData(
          color: widget.isDisabled
              ? effectiveDisabledTextColor
              : effectiveIconColor,
          size: DefaultSizes.iconSize,
        ),
        child: widget.suffixIcon!,
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label != null
            ? Padding(
          padding: EdgeInsets.only(
            bottom: DefaultSizes.labelBottomPadding,
          ),
          child:  Row(
            children: [
              Text(
                widget.label!,
                style: widget.labelStyle ??
                    TextStyle(
                      color: widget.isDisabled
                          ? effectiveDisabledTextColor
                          : DefaultColors.labelColor,
                      fontSize: DefaultSizes.labelFontSize,
                    ),
              ),
              SizedBox(width: widget.isOptionalMark ? 3 : 0,),
              widget.isOptionalMark ? Text(
                '*',
                style: widget.labelStyle ??
                    TextStyle(
                      color:  DefaultColors.errorTextColor,
                      fontSize: DefaultSizes.labelFontSize,
                    ),
              ): SizedBox(),
            ],
          ),
        )
            : const SizedBox(),
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          obscureText: _isObscured,
          onChanged: widget.isDisabled ? null : widget.onChanged,
          enabled: !widget.isDisabled,
          style: TextStyle(
            color: widget.isDisabled ? effectiveDisabledTextColor : effectiveTextColor,
            fontSize: DefaultSizes.textFontSize,
          ),
          decoration: widget.inputDecoration ??
              InputDecoration(
                hintText: widget.hint,
                hintStyle: TextStyle(
                  color: effectiveHintColor,
                  fontSize: DefaultSizes.hintFontSize,
                ),
                prefixIcon: widget.prefixIcon != null
                    ? IconTheme(
                  data: IconThemeData(
                    color: widget.isDisabled
                        ? effectiveDisabledTextColor
                        : effectiveIconColor,
                    size: DefaultSizes.iconSize,
                  ),
                  child: widget.prefixIcon!,
                )
                    : null,
                suffixIcon: effectiveSuffixIcon,
                filled: true,
                fillColor: widget.isDisabled
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
                    color: widget.isDisabled
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
            widget.errorMsg!,
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