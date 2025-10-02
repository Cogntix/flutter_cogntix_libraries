import 'package:flutter/material.dart';
import 'package:cogntix_flutter_forms/src/themes/default_colors.dart';
import 'package:cogntix_flutter_forms/src/themes/default_sizes.dart';
import 'package:intl/intl.dart';

class CustomDateField extends StatefulWidget {
  final String? label;
  final TextStyle? labelStyle;
  final String? hint;
  final DateTime? selectedDate;
  final String? errorMsg;
  final Color? errorColor;
  final void Function(DateTime selectedDate)? onChanged;
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
  final Widget? prefixIcon;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateFormat? dateFormat;
  final DatePickerMode initialDatePickerMode;

  const CustomDateField({
    Key? key,
    this.label,
    this.labelStyle,
    this.hint,
    this.selectedDate,
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
    this.prefixIcon,
    this.firstDate,
    this.lastDate,
    this.dateFormat,
    this.initialDatePickerMode = DatePickerMode.day,
  }) : super(key: key);

  @override
  State<CustomDateField> createState() => _CustomDateFieldState();
}

class _CustomDateFieldState extends State<CustomDateField> {
  DateTime? _selectedDate;
  late DateFormat _formatter;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
    _formatter = widget.dateFormat ?? DateFormat('dd MMM yyyy');
  }

  @override
  void didUpdateWidget(CustomDateField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDate != oldWidget.selectedDate) {
      _selectedDate = widget.selectedDate;
    }
    if (widget.dateFormat != oldWidget.dateFormat) {
      _formatter = widget.dateFormat ?? DateFormat('dd MMM yyyy');
    }
  }

  Future<void> _selectDate() async {
    if (widget.isDisabled) return;

    final DateTime initialDate = _selectedDate ?? DateTime.now();
    final DateTime firstDate = widget.firstDate ?? DateTime(1900);
    final DateTime lastDate = widget.lastDate ?? DateTime(2100);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      initialDatePickerMode: widget.initialDatePickerMode,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: widget.focusedBorderColor ??
                  DefaultColors.focusedBorderColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black87,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      widget.onChanged?.call(picked);
    }
  }

  void _clearDate() {
    if (widget.isDisabled) return;

    setState(() {
      _selectedDate = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final effectiveErrorColor =
        widget.errorColor ?? DefaultColors.errorBorderColor;
    final hasError = widget.errorMsg != null;
    final effectiveBorderColor = widget.borderColor ?? DefaultColors.borderColor;
    final effectiveFocusedBorderColor =
        widget.focusedBorderColor ?? DefaultColors.focusedBorderColor;
    final effectiveTextColor = widget.textColor ?? DefaultColors.textColor;
    final effectiveHintColor = widget.hintColor ?? DefaultColors.hintColor;
    final effectiveIconColor =
        widget.iconColor ?? DefaultColors.prefixIconColor;
    final effectiveDisabledBorderColor =
        widget.disabledBorderColor ?? DefaultColors.borderColor;
    final effectiveDisabledTextColor =
        widget.disabledTextColor ?? DefaultColors.hintColor;
    final effectiveDisabledBackgroundColor = widget.disabledBackgroundColor ??
        DefaultColors.disabledBackgroundColor;

    final displayText = _selectedDate != null
        ? _formatter.format(_selectedDate!)
        : widget.hint ?? 'Select date';

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        if (widget.label != null)
          Padding(
            padding: EdgeInsets.only(
              bottom: DefaultSizes.labelBottomPadding,
            ),
            child: Row(
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
                SizedBox(
                  width: widget.isOptionalMark ? 3 : 0,
                ),
                if (widget.isOptionalMark)
                  Text(
                    '*',
                    style: widget.labelStyle ??
                        TextStyle(
                          color: DefaultColors.errorTextColor,
                          fontSize: DefaultSizes.labelFontSize,
                        ),
                  ),
              ],
            ),
          ),

        // Date Field
        InkWell(
          onTap: _selectDate,
          borderRadius: BorderRadius.circular(DefaultSizes.borderRadius),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              color: widget.isDisabled
                  ? effectiveDisabledBackgroundColor
                  : DefaultColors.backgroundColor,
              borderRadius: BorderRadius.circular(DefaultSizes.borderRadius),
              border: Border.all(
                color: hasError
                    ? effectiveErrorColor
                    : widget.isDisabled
                    ? effectiveDisabledBorderColor
                    : effectiveBorderColor,
                width: DefaultSizes.normalBorderWidth,
              ),
            ),
            child: Row(
              children: [
                if (widget.prefixIcon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: IconTheme(
                      data: IconThemeData(
                        color: widget.isDisabled
                            ? effectiveDisabledTextColor
                            : effectiveIconColor,
                        size: DefaultSizes.iconSize,
                      ),
                      child: widget.prefixIcon!,
                    ),
                  ),
                Expanded(
                  child: Text(
                    displayText,
                    style: TextStyle(
                      color: _selectedDate != null
                          ? (widget.isDisabled
                          ? effectiveDisabledTextColor
                          : effectiveTextColor)
                          : effectiveHintColor,
                      fontSize: DefaultSizes.textFontSize,
                    ),
                  ),
                ),
                if (_selectedDate != null && !widget.isDisabled)
                  InkWell(
                    onTap: _clearDate,
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.clear,
                        color: effectiveIconColor,
                        size: 18,
                      ),
                    ),
                  )
                else
                  Icon(
                    Icons.calendar_today,
                    color: widget.isDisabled
                        ? effectiveDisabledTextColor
                        : effectiveIconColor,
                    size: DefaultSizes.iconSize,
                  ),
              ],
            ),
          ),
        ),

        // Error Message
        if (hasError)
          Padding(
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
          ),

        SizedBox(height: DefaultSizes.fieldBottomSpacing),
      ],
    );
  }
}