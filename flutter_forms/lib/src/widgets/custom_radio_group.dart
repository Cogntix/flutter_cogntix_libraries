import 'package:flutter/material.dart';
import 'package:cogntix_flutter_forms/src/themes/default_colors.dart';
import 'package:cogntix_flutter_forms/src/themes/default_sizes.dart';

class CustomRadioGroup extends StatefulWidget {
  final String? label;
  final TextStyle? labelStyle;
  final Map<String, String> items;
  final String? selectedKey;
  final String? errorMsg;
  final Color? errorColor;
  final void Function(String key, String value)? onChanged;
  final Color? radioActiveColor;
  final Color? radioBorderColor;
  final Color? textColor;
  final bool isDisabled;
  final bool isOptionalMark;
  final Color? disabledTextColor;
  final Color? disabledRadioColor;
  final RadioGroupLayout layout;
  final bool showAsCards;

  const CustomRadioGroup({
    Key? key,
    this.label,
    this.labelStyle,
    required this.items,
    this.selectedKey,
    this.errorMsg,
    this.errorColor,
    this.onChanged,
    this.radioActiveColor,
    this.radioBorderColor,
    this.textColor,
    this.isDisabled = false,
    this.isOptionalMark = false,
    this.disabledTextColor,
    this.disabledRadioColor,
    this.layout = RadioGroupLayout.vertical,
    this.showAsCards = false,
  }) : super(key: key);

  @override
  State<CustomRadioGroup> createState() => _CustomRadioGroupState();
}

class _CustomRadioGroupState extends State<CustomRadioGroup> {
  String? _selectedKey;

  @override
  void initState() {
    super.initState();
    _selectedKey = widget.selectedKey;
  }

  @override
  void didUpdateWidget(CustomRadioGroup oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedKey != oldWidget.selectedKey) {
      _selectedKey = widget.selectedKey;
    }
  }

  void _handleRadioChange(String key) {
    if (widget.isDisabled) return;

    setState(() {
      _selectedKey = key;
    });

    final value = widget.items[key]!;
    widget.onChanged?.call(key, value);
  }

  @override
  Widget build(BuildContext context) {
    final effectiveErrorColor =
        widget.errorColor ?? DefaultColors.errorBorderColor;
    final hasError = widget.errorMsg != null;
    final effectiveRadioActiveColor =
        widget.radioActiveColor ?? DefaultColors.focusedBorderColor;
    final effectiveRadioBorderColor =
        widget.radioBorderColor ?? DefaultColors.borderColor;
    final effectiveTextColor = widget.textColor ?? DefaultColors.textColor;
    final effectiveDisabledTextColor =
        widget.disabledTextColor ?? DefaultColors.hintColor;
    final effectiveDisabledRadioColor =
        widget.disabledRadioColor ?? DefaultColors.borderColor;

    return Column(
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

        // Radio Items
        if (widget.showAsCards)
          _buildCardsLayout(
            effectiveRadioActiveColor,
            effectiveRadioBorderColor,
            effectiveTextColor,
            effectiveDisabledTextColor,
            effectiveDisabledRadioColor,
          )
        else if (widget.layout == RadioGroupLayout.vertical)
          _buildVerticalLayout(
            effectiveRadioActiveColor,
            effectiveRadioBorderColor,
            effectiveTextColor,
            effectiveDisabledTextColor,
            effectiveDisabledRadioColor,
          )
        else
          _buildGridLayout(
            effectiveRadioActiveColor,
            effectiveRadioBorderColor,
            effectiveTextColor,
            effectiveDisabledTextColor,
            effectiveDisabledRadioColor,
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

  Widget _buildVerticalLayout(
      Color activeColor,
      Color borderColor,
      Color textColor,
      Color disabledTextColor,
      Color disabledRadioColor,
      ) {
    return Column(
      children: widget.items.entries.map((entry) {
        final key = entry.key;
        final value = entry.value;
        final isSelected = _selectedKey == key;

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.isDisabled ? null : () => _handleRadioChange(key),
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Radio<String>(
                      value: key,
                      groupValue: _selectedKey,
                      onChanged: widget.isDisabled
                          ? null
                          : (value) => _handleRadioChange(key),
                      activeColor: activeColor,
                      fillColor: MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.disabled)) {
                          return disabledRadioColor;
                        }
                        if (states.contains(MaterialState.selected)) {
                          return activeColor;
                        }
                        return borderColor;
                      }),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: DefaultSizes.textFontSize,
                        color: widget.isDisabled ? disabledTextColor : textColor,
                        fontWeight:
                        isSelected ? FontWeight.w500 : FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildGridLayout(
      Color activeColor,
      Color borderColor,
      Color textColor,
      Color disabledTextColor,
      Color disabledRadioColor,
      ) {
    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: widget.items.entries.map((entry) {
        final key = entry.key;
        final value = entry.value;
        final isSelected = _selectedKey == key;

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.isDisabled ? null : () => _handleRadioChange(key),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected
                      ? activeColor
                      : (widget.isDisabled
                      ? disabledRadioColor
                      : borderColor),
                  width: isSelected ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(8),
                color: isSelected
                    ? activeColor.withOpacity(0.1)
                    : Colors.transparent,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Radio<String>(
                      value: key,
                      groupValue: _selectedKey,
                      onChanged: widget.isDisabled
                          ? null
                          : (value) => _handleRadioChange(key),
                      activeColor: activeColor,
                      fillColor: MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.disabled)) {
                          return disabledRadioColor;
                        }
                        if (states.contains(MaterialState.selected)) {
                          return activeColor;
                        }
                        return borderColor;
                      }),
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: DefaultSizes.textFontSize - 1,
                      color: widget.isDisabled ? disabledTextColor : textColor,
                      fontWeight:
                      isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCardsLayout(
      Color activeColor,
      Color borderColor,
      Color textColor,
      Color disabledTextColor,
      Color disabledRadioColor,
      ) {
    return Column(
      children: widget.items.entries.map((entry) {
        final key = entry.key;
        final value = entry.value;
        final isSelected = _selectedKey == key;

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.isDisabled ? null : () => _handleRadioChange(key),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isSelected
                      ? activeColor.withOpacity(0.08)
                      : Colors.grey.shade50,
                  border: Border.all(
                    color: isSelected
                        ? activeColor
                        : (widget.isDisabled
                        ? disabledRadioColor
                        : borderColor),
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: isSelected
                      ? [
                    BoxShadow(
                      color: activeColor.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                      : null,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? activeColor
                              : (widget.isDisabled
                              ? disabledRadioColor
                              : borderColor),
                          width: 2,
                        ),
                        color: isSelected ? activeColor : Colors.transparent,
                      ),
                      child: isSelected
                          ? Center(
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                      )
                          : null,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: DefaultSizes.textFontSize,
                          color:
                          widget.isDisabled ? disabledTextColor : textColor,
                          fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w500,
                        ),
                      ),
                    ),
                    if (isSelected)
                      Icon(
                        Icons.check_circle,
                        color: activeColor,
                        size: 20,
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

enum RadioGroupLayout {
  vertical,
  grid,
}