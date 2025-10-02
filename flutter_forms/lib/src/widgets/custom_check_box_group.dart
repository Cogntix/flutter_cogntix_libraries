import 'package:flutter/material.dart';
import 'package:flutter_forms/src/themes/default_colors.dart';
import 'package:flutter_forms/src/themes/default_sizes.dart';

class CustomCheckboxGroup extends StatefulWidget {
  final String? label;
  final TextStyle? labelStyle;
  final Map<String, String> items;
  final List<String> selectedKeys;
  final String? errorMsg;
  final Color? errorColor;
  final void Function(List<String> selectedKeys, Map<String, String> selectedItems)? onChanged;
  final Color? checkboxActiveColor;
  final Color? checkboxBorderColor;
  final Color? textColor;
  final bool isDisabled;
  final bool isOptionalMark;
  final Color? disabledTextColor;
  final Color? disabledCheckboxColor;
  final bool showSelectAll;
  final int? maxSelection;
  final int? minSelection;
  final CheckboxGroupLayout layout;

  const CustomCheckboxGroup({
    Key? key,
    this.label,
    this.labelStyle,
    required this.items,
    this.selectedKeys = const [],
    this.errorMsg,
    this.errorColor,
    this.onChanged,
    this.checkboxActiveColor,
    this.checkboxBorderColor,
    this.textColor,
    this.isDisabled = false,
    this.isOptionalMark = false,
    this.disabledTextColor,
    this.disabledCheckboxColor,
    this.showSelectAll = false,
    this.maxSelection,
    this.minSelection,
    this.layout = CheckboxGroupLayout.vertical,
  }) : super(key: key);

  @override
  State<CustomCheckboxGroup> createState() => _CustomCheckboxGroupState();
}

class _CustomCheckboxGroupState extends State<CustomCheckboxGroup> {
  late List<String> _selectedKeys;

  @override
  void initState() {
    super.initState();
    _selectedKeys = List.from(widget.selectedKeys);
  }

  @override
  void didUpdateWidget(CustomCheckboxGroup oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedKeys != oldWidget.selectedKeys) {
      _selectedKeys = List.from(widget.selectedKeys);
    }
  }

  void _handleCheckboxChange(String key, bool? value) {
    if (widget.isDisabled) return;

    setState(() {
      if (value == true) {
        // Check max selection limit
        if (widget.maxSelection != null &&
            _selectedKeys.length >= widget.maxSelection!) {
          return;
        }
        if (!_selectedKeys.contains(key)) {
          _selectedKeys.add(key);
        }
      } else {
        _selectedKeys.remove(key);
      }
    });

    _notifyChange();
  }

  void _handleSelectAll(bool? value) {
    if (widget.isDisabled) return;

    setState(() {
      if (value == true) {
        _selectedKeys = widget.items.keys.toList();
      } else {
        _selectedKeys.clear();
      }
    });

    _notifyChange();
  }

  void _notifyChange() {
    final selectedItems = <String, String>{};
    for (var key in _selectedKeys) {
      if (widget.items.containsKey(key)) {
        selectedItems[key] = widget.items[key]!;
      }
    }
    widget.onChanged?.call(_selectedKeys, selectedItems);
  }

  bool get _isAllSelected {
    return _selectedKeys.length == widget.items.length &&
        widget.items.isNotEmpty;
  }

  bool get _isSomeSelected {
    return _selectedKeys.isNotEmpty && !_isAllSelected;
  }

  @override
  Widget build(BuildContext context) {
    final effectiveErrorColor =
        widget.errorColor ?? DefaultColors.errorBorderColor;
    final hasError = widget.errorMsg != null;
    final effectiveCheckboxActiveColor =
        widget.checkboxActiveColor ?? DefaultColors.focusedBorderColor;
    final effectiveCheckboxBorderColor =
        widget.checkboxBorderColor ?? DefaultColors.borderColor;
    final effectiveTextColor = widget.textColor ?? DefaultColors.textColor;
    final effectiveDisabledTextColor =
        widget.disabledTextColor ?? DefaultColors.hintColor;
    final effectiveDisabledCheckboxColor =
        widget.disabledCheckboxColor ?? DefaultColors.borderColor;

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

        // Select All Option
        if (widget.showSelectAll && widget.items.isNotEmpty)
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.isDisabled
                  ? null
                  : () => _handleSelectAll(!_isAllSelected),
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: _isAllSelected,
                        tristate: true,
                        onChanged: widget.isDisabled ? null : _handleSelectAll,
                        activeColor: effectiveCheckboxActiveColor,
                        checkColor: Colors.white,
                        side: BorderSide(
                          color: widget.isDisabled
                              ? effectiveDisabledCheckboxColor
                              : effectiveCheckboxBorderColor,
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Select All',
                        style: TextStyle(
                          fontSize: DefaultSizes.textFontSize,
                          color: widget.isDisabled
                              ? effectiveDisabledTextColor
                              : effectiveTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

        if (widget.showSelectAll && widget.items.isNotEmpty)
          Divider(
            height: 16,
            thickness: 1,
            color: Colors.grey.shade300,
          ),

        // Checkbox Items
        widget.layout == CheckboxGroupLayout.vertical
            ? _buildVerticalLayout(
          effectiveCheckboxActiveColor,
          effectiveCheckboxBorderColor,
          effectiveTextColor,
          effectiveDisabledTextColor,
          effectiveDisabledCheckboxColor,
        )
            : _buildGridLayout(
          effectiveCheckboxActiveColor,
          effectiveCheckboxBorderColor,
          effectiveTextColor,
          effectiveDisabledTextColor,
          effectiveDisabledCheckboxColor,
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
      Color disabledCheckboxColor,
      ) {
    return Column(
      children: widget.items.entries.map((entry) {
        final key = entry.key;
        final value = entry.value;
        final isSelected = _selectedKeys.contains(key);

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.isDisabled
                ? null
                : () => _handleCheckboxChange(key, !isSelected),
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: isSelected,
                      onChanged: widget.isDisabled
                          ? null
                          : (value) => _handleCheckboxChange(key, value),
                      activeColor: activeColor,
                      checkColor: Colors.white,
                      side: BorderSide(
                        color: widget.isDisabled
                            ? disabledCheckboxColor
                            : borderColor,
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: DefaultSizes.textFontSize,
                        color: widget.isDisabled ? disabledTextColor : textColor,
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
      Color disabledCheckboxColor,
      ) {
    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: widget.items.entries.map((entry) {
        final key = entry.key;
        final value = entry.value;
        final isSelected = _selectedKeys.contains(key);

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.isDisabled
                ? null
                : () => _handleCheckboxChange(key, !isSelected),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected
                      ? activeColor
                      : (widget.isDisabled
                      ? disabledCheckboxColor
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
                    child: Checkbox(
                      value: isSelected,
                      onChanged: widget.isDisabled
                          ? null
                          : (value) => _handleCheckboxChange(key, value),
                      activeColor: activeColor,
                      checkColor: Colors.white,
                      side: BorderSide(
                        color: widget.isDisabled
                            ? disabledCheckboxColor
                            : borderColor,
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: DefaultSizes.textFontSize - 1,
                      color: widget.isDisabled ? disabledTextColor : textColor,
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
}

enum CheckboxGroupLayout {
  vertical,
  grid,
}