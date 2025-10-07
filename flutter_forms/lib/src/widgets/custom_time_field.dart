import 'package:flutter/material.dart';
import 'package:cogntix_flutter_forms/src/themes/default_colors.dart';
import 'package:cogntix_flutter_forms/src/themes/default_sizes.dart';

class CustomTimeField extends StatefulWidget {
  final String? label;
  final TextStyle? labelStyle;
  final String? hint;
  final TimeOfDay? selectedTime;
  final String? errorMsg;
  final Color? errorColor;
  final void Function(TimeOfDay selectedTime)? onChanged;
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
  final bool use24HourFormat;
  final TimePickerEntryMode initialEntryMode;

  const CustomTimeField({
    Key? key,
    this.label,
    this.labelStyle,
    this.hint,
    this.selectedTime,
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
    this.use24HourFormat = false,
    this.initialEntryMode = TimePickerEntryMode.dial,
  }) : super(key: key);

  @override
  State<CustomTimeField> createState() => _CustomTimeFieldState();
}

class _CustomTimeFieldState extends State<CustomTimeField> {
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.selectedTime;
  }

  @override
  void didUpdateWidget(CustomTimeField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedTime != oldWidget.selectedTime) {
      _selectedTime = widget.selectedTime;
    }
  }

  Future<void> _selectTime() async {
    if (widget.isDisabled) return;

    final TimeOfDay initialTime = _selectedTime ?? TimeOfDay.now();

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      initialEntryMode: widget.initialEntryMode,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: widget.use24HourFormat,
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: widget.focusedBorderColor ??
                    DefaultColors.focusedBorderColor,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black87,
              ),
              timePickerTheme: TimePickerThemeData(
              backgroundColor: Colors.white,
              hourMinuteTextColor: MaterialStateColor.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return Colors.white; // White text when selected
                }
                return Colors.black87; // Dark text when not selected
              }),
              dayPeriodTextColor: MaterialStateColor.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return Colors.white; // White text when selected
                }
                return Colors.black87; // Dark text when not selected
              }),
              dialHandColor: widget.focusedBorderColor ??
                  DefaultColors.focusedBorderColor,
              dialBackgroundColor: (widget.focusedBorderColor ??
                  DefaultColors.focusedBorderColor)
                  .withOpacity(0.1),
              dialTextColor: MaterialStateColor.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return Colors.white; // White text for selected number on dial
                }
                return Colors.black87; // Dark text for unselected numbers
              }),
              hourMinuteTextStyle: const TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),
            ),
            ),
            child: child!,
          ),
        );
      },
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
      widget.onChanged?.call(picked);
    }
  }

  void _clearTime() {
    if (widget.isDisabled) return;

    setState(() {
      _selectedTime = null;
    });
  }

  String _formatTime(TimeOfDay time) {
    if (widget.use24HourFormat) {
      final hour = time.hour.toString().padLeft(2, '0');
      final minute = time.minute.toString().padLeft(2, '0');
      return '$hour:$minute';
    } else {
      final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
      final minute = time.minute.toString().padLeft(2, '0');
      final period = time.period == DayPeriod.am ? 'AM' : 'PM';
      return '$hour:$minute $period';
    }
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

    final displayText = _selectedTime != null
        ? _formatTime(_selectedTime!)
        : widget.hint ?? 'Select time';

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

        // Time Field
        InkWell(
          onTap: _selectTime,
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
                      color: _selectedTime != null
                          ? (widget.isDisabled
                          ? effectiveDisabledTextColor
                          : effectiveTextColor)
                          : effectiveHintColor,
                      fontSize: DefaultSizes.textFontSize,
                    ),
                  ),
                ),
                if (_selectedTime != null && !widget.isDisabled)
                  InkWell(
                    onTap: _clearTime,
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
                    Icons.access_time,
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