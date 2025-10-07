import 'package:flutter/material.dart';
import 'package:cogntix_flutter_forms/src/themes/default_colors.dart';
import 'package:cogntix_flutter_forms/src/themes/default_sizes.dart';

class CustomDropdownField extends StatefulWidget {
  final String? label;
  final TextStyle? labelStyle;
  final String? hint;
  final Map<String, String> items;
  final String? selectedKey;
  final String? errorMsg;
  final Color? errorColor;
  final void Function(String key, String value)? onChanged;
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

  const CustomDropdownField({
    Key? key,
    this.label,
    this.labelStyle,
    this.hint,
    required this.items,
    this.selectedKey,
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
  }) : super(key: key);

  @override
  State<CustomDropdownField> createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  String? _selectedKey;
  final TextEditingController _searchController = TextEditingController();
  List<MapEntry<String, String>> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _selectedKey = widget.selectedKey;
    _filteredItems = widget.items.entries.toList();
  }

  @override
  void didUpdateWidget(CustomDropdownField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedKey != oldWidget.selectedKey) {
      _selectedKey = widget.selectedKey;
    }
    if (widget.items != oldWidget.items) {
      _filteredItems = widget.items.entries.toList();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterItems(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredItems = widget.items.entries.toList();
      } else {
        _filteredItems = widget.items.entries
            .where((entry) =>
            entry.value.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _showDropdownDialog() {
    if (widget.isDisabled) return;

    _searchController.clear();
    _filteredItems = widget.items.entries.toList();

    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.label ?? 'Select Option',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1A1A1A),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, size: 24),
                            color: Colors.grey.shade600,
                            onPressed: () => Navigator.of(context).pop(),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            splashRadius: 20,
                          ),
                        ],
                      ),
                    ),

                    // Search Bar
                    if (widget.items.length > 5)
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                        child: TextField(
                          controller: _searchController,
                          onChanged: (value) {
                            setDialogState(() {
                              _filterItems(value);
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            hintStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 15,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey.shade400,
                              size: 22,
                            ),
                            suffixIcon: _searchController.text.isNotEmpty
                                ? IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: Colors.grey.shade400,
                                size: 20,
                              ),
                              onPressed: () {
                                setDialogState(() {
                                  _searchController.clear();
                                  _filterItems('');
                                });
                              },
                            )
                                : null,
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),

                    // Items List
                    Flexible(
                      child: _filteredItems.isEmpty
                          ? Padding(
                        padding: const EdgeInsets.all(40),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 48,
                              color: Colors.grey.shade300,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'No results found',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )
                          : ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: _filteredItems.length,
                        itemBuilder: (context, index) {
                          final entry = _filteredItems[index];
                          final key = entry.key;
                          final value = entry.value;
                          final isSelected = _selectedKey == key;

                          return Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedKey = key;
                                });
                                widget.onChanged?.call(key, value);
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 14,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? DefaultColors.focusedBorderColor
                                      .withOpacity(0.08)
                                      : Colors.transparent,
                                  border: Border(
                                    left: BorderSide(
                                      color: isSelected
                                          ? DefaultColors.focusedBorderColor
                                          : Colors.transparent,
                                      width: 3,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: isSelected
                                              ? DefaultColors
                                              .focusedBorderColor
                                              : const Color(0xFF2C2C2C),
                                          fontWeight: isSelected
                                              ? FontWeight.w600
                                              : FontWeight.w400,
                                          letterSpacing: 0.2,
                                        ),
                                      ),
                                    ),
                                    if (isSelected)
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: DefaultColors
                                              .focusedBorderColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 14,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
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

    final selectedValue = _selectedKey != null ? widget.items[_selectedKey] : null;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label != null
            ? Padding(
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
              widget.isOptionalMark
                  ? Text(
                '*',
                style: widget.labelStyle ??
                    TextStyle(
                      color: DefaultColors.errorTextColor,
                      fontSize: DefaultSizes.labelFontSize,
                    ),
              )
                  : SizedBox(),
            ],
          ),
        )
            : const SizedBox(),
        InkWell(
          onTap: _showDropdownDialog,
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
                    selectedValue ?? widget.hint ?? 'Select an option',
                    style: TextStyle(
                      color: selectedValue != null
                          ? (widget.isDisabled
                          ? effectiveDisabledTextColor
                          : effectiveTextColor)
                          : effectiveHintColor,
                      fontSize: DefaultSizes.textFontSize,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: widget.isDisabled
                      ? effectiveDisabledTextColor
                      : effectiveIconColor,
                  size: DefaultSizes.iconSize,
                ),
              ],
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