# Flutter Forms

A comprehensive Flutter package providing a collection of customizable, reusable form widgets with built-in validation. Designed by Cogntix to simplify form creation and maintain consistency across Flutter applications.

## Features

✨ **10 Ready-to-Use Form Widgets**
- Text Fields (Standard & with Button)
- Phone Number Fields (Standard & with Button)
- Dropdown Selection
- Checkbox Groups
- Radio Button Groups
- Date & Time Pickers
- Custom Buttons

🎨 **Highly Customizable**
- Consistent styling across all widgets
- Optional/Required field markers
- Custom colors, icons, and layouts
- Error message support

✅ **Built-in Validators**
- Email validation
- Password validation
- Phone number validation
- Name validation
- Date/Time validation
- Custom validation support

## Installation
Clone this library and move to your root directory and then add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_forms:
    path: add the cloned location
  phone_form_field: ^9.0.0  # Required for phone fields
  intl: ^0.20.2             # Required for date formatting
```

Then run:

```bash
flutter pub get
```

## Quick Start

```dart
import 'package:flutter/material.dart';
import 'package:flutter_forms/flutter_forms.dart';

class MyForm extends StatefulWidget {
  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _nameController = TextEditingController();
  String? _nameError;

  void _onNameChanged(String value) {
    setState(() {
      _nameError = FormValidators.validateName(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: 'Full Name',
      hint: 'Enter your full name',
      controller: _nameController,
      errorMsg: _nameError,
      onChanged: _onNameChanged,
    );
  }
}
```

## Widgets Documentation

### 1. CustomTextField

A customizable text input field with validation support.

#### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `label` | `String` | Required | Label text displayed above the field |
| `hint` | `String?` | `null` | Placeholder text |
| `controller` | `TextEditingController` | Required | Controller for the text field |
| `errorMsg` | `String?` | `null` | Error message to display |
| `onChanged` | `Function(String)?` | `null` | Callback when text changes |
| `keyboardType` | `TextInputType?` | `null` | Keyboard type |
| `obscureText` | `bool` | `false` | Hide text (for passwords) |
| `prefixIcon` | `Widget?` | `null` | Icon at the start of field |
| `suffixIcon` | `Widget?` | `null` | Icon at the end of field |
| `isOptionalMark` | `bool` | `false` | Show "(Optional)" marker |
| `maxLines` | `int` | `1` | Maximum number of lines |
| `enabled` | `bool` | `true` | Enable/disable field |

#### Example

```dart
CustomTextField(
  label: 'Email',
  hint: 'Enter your email',
  controller: _emailController,
  prefixIcon: const Icon(Icons.email),
  errorMsg: _emailError,
  keyboardType: TextInputType.emailAddress,
  isOptionalMark: true,
  onChanged: (value) {
    setState(() {
      _emailError = FormValidators.validateEmail(value);
    });
  },
)
```

---

### 2. CustomTextFieldWithButton

A text field with an integrated action button (e.g., for verification).

#### Parameters

All parameters from `CustomTextField` plus:

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `buttonText` | `String` | Required | Text displayed on button |
| `onButtonPressed` | `VoidCallback` | Required | Callback when button is pressed |
| `buttonColor` | `Color?` | `Colors.blue` | Button background color |
| `buttonTextColor` | `Color?` | `Colors.white` | Button text color |

#### Example

```dart
CustomTextFieldWithButton(
  label: 'Email',
  hint: 'Enter your email',
  controller: _emailController,
  buttonText: 'Verify',
  errorMsg: _emailError,
  onChanged: (value) {
    setState(() {
      _emailError = FormValidators.validateEmail(value);
    });
  },
  onButtonPressed: () {
    // Handle verification logic
    print('Verify clicked');
  },
)
```

---

### 3. CustomPhoneTextField

A phone number input field with country code selector.

#### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `label` | `String` | Required | Label text displayed above the field |
| `controller` | `PhoneController` | Required | Phone controller from phone_form_field |
| `errorMsg` | `String?` | `null` | Error message to display |
| `onChanged` | `Function(PhoneNumber?)?` | `null` | Callback when phone changes |
| `isOptionalMark` | `bool` | `false` | Show "(Optional)" marker |
| `enabled` | `bool` | `true` | Enable/disable field |

#### Example

```dart
import 'package:phone_form_field/phone_form_field.dart';

final _phoneController = PhoneController();

// In initState:
_phoneController.value = PhoneNumber(isoCode: IsoCode.LK, nsn: '');

// In build:
CustomPhoneTextField(
  label: 'Phone Number',
  controller: _phoneController,
  errorMsg: _phoneError,
  isOptionalMark: true,
  onChanged: (phoneNumber) {
    setState(() {
      _phoneError = FormValidators.validatePhone(phoneNumber);
    });
  },
)
```

---

### 4. CustomPhoneTextFieldWithButton

A phone number field with an integrated action button.

#### Parameters

All parameters from `CustomPhoneTextField` plus:

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `buttonText` | `String` | Required | Text displayed on button |
| `onButtonPressed` | `VoidCallback` | Required | Callback when button is pressed |
| `buttonColor` | `Color?` | `Colors.blue` | Button background color |
| `buttonTextColor` | `Color?` | `Colors.white` | Button text color |

#### Example

```dart
CustomPhoneTextFieldWithButton(
  label: 'Phone Number',
  controller: _phoneController,
  buttonText: 'Verify',
  onChanged: (phoneNumber) {
    setState(() {
      _phoneError = FormValidators.validatePhone(phoneNumber);
    });
  },
  onButtonPressed: () {
    // Handle OTP verification
  },
  buttonColor: Colors.blue,
  errorMsg: _phoneError,
)
```

---

### 5. CustomDropdownField

A dropdown selection field with search functionality.

#### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `label` | `String` | Required | Label text displayed above the field |
| `hint` | `String?` | `null` | Placeholder text |
| `items` | `Map<String, String>` | Required | Key-value pairs for dropdown items |
| `selectedKey` | `String?` | `null` | Currently selected key |
| `onChanged` | `Function(String, String)` | Required | Callback with (key, value) |
| `errorMsg` | `String?` | `null` | Error message to display |
| `prefixIcon` | `Widget?` | `null` | Icon at the start of field |
| `isOptionalMark` | `bool` | `false` | Show "(Optional)" marker |
| `enabled` | `bool` | `true` | Enable/disable field |

#### Example

```dart
final Map<String, String> _countries = {
  'US': 'United States',
  'UK': 'United Kingdom',
  'LK': 'Sri Lanka',
  'IN': 'India',
};

String? _selectedCountryKey;

CustomDropdownField(
  label: 'Country',
  hint: 'Select your country',
  items: _countries,
  selectedKey: _selectedCountryKey,
  prefixIcon: const Icon(Icons.public),
  errorMsg: _countryError,
  isOptionalMark: true,
  onChanged: (key, value) {
    setState(() {
      _selectedCountryKey = key;
      _countryError = null;
      print('Selected: $key - $value');
    });
  },
)
```

---

### 6. CustomCheckboxGroup

A group of checkboxes for multiple selection.

#### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `label` | `String` | Required | Label text displayed above the group |
| `items` | `Map<String, String>` | Required | Key-value pairs for checkbox items |
| `selectedKeys` | `List<String>` | Required | List of currently selected keys |
| `onChanged` | `Function(List<String>, Map<String, String>)` | Required | Callback with selected keys and items |
| `errorMsg` | `String?` | `null` | Error message to display |
| `isOptionalMark` | `bool` | `false` | Show "(Optional)" marker |
| `showSelectAll` | `bool` | `false` | Show "Select All" option |
| `layout` | `CheckboxGroupLayout` | `vertical` | Layout: `vertical` or `grid` |
| `crossAxisCount` | `int` | `2` | Number of columns (grid layout only) |

#### Example

```dart
final Map<String, String> _hobbies = {
  'reading': 'Reading',
  'gaming': 'Gaming',
  'sports': 'Sports',
  'music': 'Music',
};

List<String> _selectedHobbies = [];

CustomCheckboxGroup(
  label: 'Select Your Hobbies (Min 2)',
  items: _hobbies,
  selectedKeys: _selectedHobbies,
  onChanged: (selectedKeys, selectedItems) {
    setState(() {
      _selectedHobbies = selectedKeys;
      _hobbiesError = FormValidators.validateCheckboxGroup(
        selectedKeys,
        fieldName: 'hobby',
      );
    });
  },
  errorMsg: _hobbiesError,
  showSelectAll: true,
  isOptionalMark: true,
  layout: CheckboxGroupLayout.vertical,
)
```

---

### 7. CustomRadioGroup

A group of radio buttons for single selection.

#### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `label` | `String` | Required | Label text displayed above the group |
| `items` | `Map<String, String>` | Required | Key-value pairs for radio items |
| `selectedKey` | `String?` | `null` | Currently selected key |
| `onChanged` | `Function(String, String)` | Required | Callback with (key, value) |
| `errorMsg` | `String?` | `null` | Error message to display |
| `isOptionalMark` | `bool` | `false` | Show "(Optional)" marker |
| `layout` | `RadioGroupLayout` | `vertical` | Layout: `vertical` or `grid` |
| `crossAxisCount` | `int` | `2` | Number of columns (grid layout only) |

#### Example

```dart
final Map<String, String> _genders = {
  'M': 'Male',
  'F': 'Female',
  'O': 'Other',
  'N': 'Prefer not to say',
};

String? _selectedGender;

CustomRadioGroup(
  label: 'Gender',
  items: _genders,
  selectedKey: _selectedGender,
  onChanged: (key, value) {
    setState(() {
      _selectedGender = key;
      _genderError = FormValidators.validateRadioGroup(
        key,
        fieldName: 'a gender',
      );
      print('Selected: $key - $value');
    });
  },
  errorMsg: _genderError,
  isOptionalMark: true,
  layout: RadioGroupLayout.vertical,
)
```

---

### 8. CustomDateField

A date picker field with customizable date range and format.

#### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `label` | `String` | Required | Label text displayed above the field |
| `hint` | `String?` | `null` | Placeholder text |
| `selectedDate` | `DateTime?` | `null` | Currently selected date |
| `onChanged` | `Function(DateTime)` | Required | Callback when date is selected |
| `errorMsg` | `String?` | `null` | Error message to display |
| `prefixIcon` | `Widget?` | `null` | Icon at the start of field |
| `isOptionalMark` | `bool` | `false` | Show "(Optional)" marker |
| `firstDate` | `DateTime?` | `null` | Earliest selectable date |
| `lastDate` | `DateTime?` | `null` | Latest selectable date |
| `dateFormat` | `DateFormat?` | `DateFormat('dd-MM-yyyy')` | Date display format |
| `enabled` | `bool` | `true` | Enable/disable field |

#### Example

```dart
import 'package:intl/intl.dart';

DateTime? _selectedBirthDate;

CustomDateField(
  label: 'Date of Birth',
  hint: 'Select your birth date',
  selectedDate: _selectedBirthDate,
  onChanged: (selectedDate) {
    setState(() {
      _selectedBirthDate = selectedDate;
      _birthDateError = FormValidators.validateDate(selectedDate);
    });
  },
  errorMsg: _birthDateError,
  prefixIcon: const Icon(Icons.cake),
  isOptionalMark: true,
  lastDate: DateTime.now(),
  firstDate: DateTime(1900),
  dateFormat: DateFormat('dd/MM/yyyy'),
)
```

---

### 9. CustomTimeField

A time picker field with 12/24 hour format support.

#### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `label` | `String` | Required | Label text displayed above the field |
| `hint` | `String?` | `null` | Placeholder text |
| `selectedTime` | `TimeOfDay?` | `null` | Currently selected time |
| `onChanged` | `Function(TimeOfDay)` | Required | Callback when time is selected |
| `errorMsg` | `String?` | `null` | Error message to display |
| `prefixIcon` | `Widget?` | `null` | Icon at the start of field |
| `isOptionalMark` | `bool` | `false` | Show "(Optional)" marker |
| `use24HourFormat` | `bool` | `false` | Use 24-hour time format |
| `initialEntryMode` | `TimePickerEntryMode` | `dial` | Initial picker mode: `dial` or `input` |
| `enabled` | `bool` | `true` | Enable/disable field |

#### Example

```dart
TimeOfDay? _selectedTime;

CustomTimeField(
  label: 'Preferred Time',
  hint: 'Select a time',
  selectedTime: _selectedTime,
  onChanged: (selectedTime) {
    setState(() {
      _selectedTime = selectedTime;
      _timeError = FormValidators.validateTime(selectedTime);
    });
  },
  errorMsg: _timeError,
  prefixIcon: const Icon(Icons.access_time),
  isOptionalMark: true,
  use24HourFormat: false,
  initialEntryMode: TimePickerEntryMode.dial,
)
```

---

### 10. CustomButton

A customizable button with loading state support.

#### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `text` | `String` | Required | Button text |
| `onPressed` | `VoidCallback?` | Required | Callback when pressed |
| `isLoading` | `bool` | `false` | Show loading indicator |
| `backgroundColor` | `Color?` | `Colors.blue` | Button background color |
| `textColor` | `Color?` | `Colors.white` | Button text color |
| `disabledBackgroundColor` | `Color?` | `Colors.grey` | Disabled state color |
| `loadingIndicatorColor` | `Color?` | `Colors.white` | Loading spinner color |
| `width` | `double?` | `double.infinity` | Button width |
| `height` | `double` | `50` | Button height |
| `borderRadius` | `double` | `10` | Corner radius |
| `fontSize` | `double` | `18` | Text font size |
| `fontWeight` | `FontWeight?` | `null` | Text font weight |
| `padding` | `EdgeInsetsGeometry?` | `null` | Internal padding |
| `prefixIcon` | `Widget?` | `null` | Icon before text |
| `suffixIcon` | `Widget?` | `null` | Icon after text |

#### Example

```dart
CustomButton(
  text: 'Submit',
  onPressed: _submitForm,
  isLoading: _isSubmitting,
  backgroundColor: Colors.blue,
  textColor: Colors.white,
  height: 50,
  borderRadius: 10,
  fontSize: 18,
  prefixIcon: const Icon(Icons.send, color: Colors.white),
)
```

---

## Form Validators

The package includes built-in validators for common form fields.

### Available Validators

#### `validateName(String? value, {String? fieldName})`
Validates name fields (non-empty, minimum 2 characters).

```dart
String? error = FormValidators.validateName(value);
```

#### `validateEmail(String? value)`
Validates email format.

```dart
String? error = FormValidators.validateEmail(value);
```

#### `validatePassword(String? value, {int minLength})`
Validates password strength (default minimum 6 characters).

```dart
String? error = FormValidators.validatePassword(value, minLength: 8);
```

#### `validatePhone(PhoneNumber? phoneNumber)`
Validates phone number format.

```dart
String? error = FormValidators.validatePhone(phoneNumber);
```

#### `validateDropdown(String? value, {String? fieldName})`
Validates dropdown selection.

```dart
String? error = FormValidators.validateDropdown(value, fieldName: 'country');
```

#### `validateCheckboxGroup(List<String>? selectedKeys, {String? fieldName, int minSelection})`
Validates checkbox group selection (default minimum 1).

```dart
String? error = FormValidators.validateCheckboxGroup(
  selectedKeys,
  fieldName: 'hobby',
  minSelection: 2,
);
```

#### `validateRadioGroup(String? value, {String? fieldName})`
Validates radio button selection.

```dart
String? error = FormValidators.validateRadioGroup(value, fieldName: 'gender');
```

#### `validateDate(DateTime? date, {String? fieldName})`
Validates date selection.

```dart
String? error = FormValidators.validateDate(date);
```

#### `validateTime(TimeOfDay? time, {String? fieldName})`
Validates time selection.

```dart
String? error = FormValidators.validateTime(time);
```

---

## Complete Example

Here's a complete form example demonstrating all widgets:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_forms/flutter_forms.dart';
import 'package:intl/intl.dart';
import 'package:phone_form_field/phone_form_field.dart';

class CompleteFormExample extends StatefulWidget {
  const CompleteFormExample({super.key});

  @override
  State<CompleteFormExample> createState() => _CompleteFormExampleState();
}

class _CompleteFormExampleState extends State<CompleteFormExample> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = PhoneController();
  
  String? _selectedCountry;
  List<String> _selectedHobbies = [];
  String? _selectedGender;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  
  String? _nameError;
  String? _emailError;
  String? _phoneError;
  bool _isSubmitting = false;

  final Map<String, String> _countries = {
    'US': 'United States',
    'UK': 'United Kingdom',
    'LK': 'Sri Lanka',
  };

  @override
  void initState() {
    super.initState();
    _phoneController.value = PhoneNumber(isoCode: IsoCode.LK, nsn: '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    setState(() {
      _nameError = FormValidators.validateName(_nameController.text);
      _emailError = FormValidators.validateEmail(_emailController.text);
      _phoneError = FormValidators.validatePhone(_phoneController.value);
    });

    if (_nameError == null && _emailError == null && _phoneError == null) {
      setState(() => _isSubmitting = true);
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      setState(() => _isSubmitting = false);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Form submitted successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Forms Example')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                label: 'Full Name',
                hint: 'Enter your full name',
                controller: _nameController,
                errorMsg: _nameError,
                onChanged: (value) {
                  setState(() {
                    _nameError = FormValidators.validateName(value);
                  });
                },
              ),
              CustomTextField(
                label: 'Email',
                hint: 'Enter your email',
                controller: _emailController,
                prefixIcon: const Icon(Icons.email),
                errorMsg: _emailError,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  setState(() {
                    _emailError = FormValidators.validateEmail(value);
                  });
                },
              ),
              CustomPhoneTextField(
                label: 'Phone Number',
                controller: _phoneController,
                errorMsg: _phoneError,
                onChanged: (phoneNumber) {
                  setState(() {
                    _phoneError = FormValidators.validatePhone(phoneNumber);
                  });
                },
              ),
              CustomDropdownField(
                label: 'Country',
                hint: 'Select your country',
                items: _countries,
                selectedKey: _selectedCountry,
                onChanged: (key, value) {
                  setState(() => _selectedCountry = key);
                },
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Submit',
                onPressed: _submitForm,
                isLoading: _isSubmitting,
                backgroundColor: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## Styling and Theming

All widgets support custom styling through parameters. For app-wide consistency, consider wrapping your app with a theme:

```dart
MaterialApp(
  theme: ThemeData(
    primarySwatch: Colors.blue,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
  home: MyFormPage(),
);
```

---

## Requirements

- Flutter SDK: `>=1.17.0`
- Dart SDK: `^3.9.0`

### Dependencies

- `phone_form_field: ^9.0.0` - For phone number fields
- `intl: ^0.20.2` - For date formatting

---

## Contributing

Contributions are welcome! If you find a bug or want to add a feature:

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

---

## License

This package is developed and maintained by **Cogntix**.

---

## Support

For issues, questions, or suggestions, please contact the Cogntix team or create an issue in the repository.

---

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for version history and updates.

---

## Example Project

A complete example demonstrating all widgets is available in the `example/` directory. To run it:

```bash
cd example
flutter run
```

---

**Made with ❤️ by Cogntix**

