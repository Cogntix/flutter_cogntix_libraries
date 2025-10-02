import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? disabledBackgroundColor;
  final Color? loadingIndicatorColor;
  final double? width;
  final double height;
  final double borderRadius;
  final double fontSize;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.disabledBackgroundColor,
    this.loadingIndicatorColor,
    this.width,
    this.height = 50,
    this.borderRadius = 10,
    this.fontSize = 18,
    this.fontWeight,
    this.padding,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final effectiveBackgroundColor = backgroundColor ?? Colors.blue;
    final effectiveTextColor = textColor ?? Colors.white;
    final effectiveDisabledColor = disabledBackgroundColor ?? Colors.grey;
    final effectiveLoadingColor = loadingIndicatorColor ?? Colors.white;

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: effectiveBackgroundColor,
          disabledBackgroundColor: effectiveDisabledColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: padding,
        ),
        child: isLoading
            ? SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            valueColor: AlwaysStoppedAnimation<Color>(
              effectiveLoadingColor,
            ),
          ),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (prefixIcon != null) ...[
              prefixIcon!,
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                color: effectiveTextColor,
                fontWeight: fontWeight,
              ),
            ),
            if (suffixIcon != null) ...[
              const SizedBox(width: 8),
              suffixIcon!,
            ],
          ],
        ),
      ),
    );
  }
}