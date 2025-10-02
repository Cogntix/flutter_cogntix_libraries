import 'package:flutter/material.dart';
import 'package:flutter_forms/flutter_forms.dart';
import 'package:intl/intl.dart';
import 'package:phone_form_field/phone_form_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const FormExample(),
    );
  }
}

class FormExample extends StatefulWidget {
  const FormExample({super.key});

  @override
  State<FormExample> createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = PhoneController();
  final _phoneSuffixController = PhoneController();
  String? _selectedCountryKey;
  final _email2Controller = TextEditingController();
  List<String> _selectedHobbies = [];
  String? _selectedGender;
  DateTime? _selectedBirthDate;
  TimeOfDay? _selectedTime;

  String? _nameError;
  String? _emailError;
  String? _email2Error;
  String? _passwordError;
  String? _phoneError;
  String? _phoneSuffixError;
  String? _countryError;
  String? _hobbiesError;
  String? _genderError;
  String? _birthDateError;
  String? _timeError;

  final Map<String, String> _countries = {
    'US': 'United States',
    'UK': 'United Kingdom',
    'LK': 'Sri Lanka',
    'IN': 'India',
    'AU': 'Australia',
    'CA': 'Canada',
  };

  final Map<String, String> _hobbies = {
    'reading': 'Reading',
    'gaming': 'Gaming',
    'sports': 'Sports',
    'music': 'Music',
    'cooking': 'Cooking',
    'traveling': 'Traveling',
    'photography': 'Photography',
    'art': 'Art & Crafts',
  };

  final Map<String, String> _genders = {
    'M': 'Male',
    'F': 'Female',
    'O': 'Other',
    'N': 'Prefer not to say',
  };

  @override
  void initState() {
    super.initState();
    _phoneController.value = PhoneNumber(isoCode: IsoCode.LK, nsn: '');
    _phoneSuffixController.value = PhoneNumber(isoCode: IsoCode.LK, nsn: '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _phoneSuffixController.dispose();
    _email2Controller.dispose();
    super.dispose();
  }

  void _onNameChanged(String value) {
    setState(() {
      _nameError = FormValidators.validateName(value);
    });
  }

  void _onEmailChanged(String value) {
    setState(() {
      _emailError = FormValidators.validateEmail(value);
    });
  }

  void _onEmail2Changed(String value) {
    setState(() {
      _email2Error = FormValidators.validateEmail(value);
    });
  }

  void _onPasswordChanged(String value) {
    setState(() {
      _passwordError = FormValidators.validatePassword(value);
    });
  }

  void _onPhoneChanged(PhoneNumber? phoneNumber) {
    setState(() {
      _phoneError = FormValidators.validatePhone(phoneNumber);
    });
  }

  void _onPhoneSuffixChanged(PhoneNumber? phoneNumber) {
    setState(() {
      _phoneSuffixError = FormValidators.validatePhone(phoneNumber);
    });
  }

  void _onCountryChanged(String key, String value) {
    setState(() {
      _selectedCountryKey = key;
      _countryError = null;
      print('Selected Key: $key, Selected Value: $value');
    });
  }

  void _onHobbiesChanged(List<String> selectedKeys, Map<String, String> selectedItems) {
    setState(() {
      _selectedHobbies = selectedKeys;
      _hobbiesError = FormValidators.validateCheckboxGroup(
        selectedKeys,
        fieldName: 'hobby',
      );
    });
  }

  void _onGenderChanged(String key, String value) {
    setState(() {
      _selectedGender = key;
      _genderError = FormValidators.validateRadioGroup(
        key,
        fieldName: 'a gender',
      );
      print('Selected Gender Key: $key, Value: $value');
    });
  }

  void _onBirthDateChanged(DateTime selectedDate) {
    setState(() {
      _selectedBirthDate = selectedDate;
      _birthDateError = FormValidators.validateDate(
        selectedDate,
      );

    });
  }

  void _onTimeChanged(TimeOfDay selectedTime) {
    setState(() {
      _selectedTime = selectedTime;
      _timeError = FormValidators.validateTime(selectedTime);
    });
  }


  void _submitForm() {
    setState(() {
      _nameError = FormValidators.validateName(_nameController.text);
      _emailError = FormValidators.validateEmail(_emailController.text);
      _email2Error = FormValidators.validateEmail(_email2Controller.text);
      _passwordError = FormValidators.validatePassword(_passwordController.text);
      _phoneError = FormValidators.validatePhone(_phoneController.value);
      _phoneSuffixError = FormValidators.validatePhone(_phoneSuffixController.value);
      _countryError = FormValidators.validateDropdown(_selectedCountryKey);
      _hobbiesError = FormValidators.validateCheckboxGroup(
        _selectedHobbies,
        fieldName: 'hobby',
      );
      _genderError = FormValidators.validateRadioGroup(
        _selectedGender,
        fieldName: 'a gender',
      );
      _birthDateError = FormValidators.validateDate(
        _selectedBirthDate,
      );

    });
    _timeError = FormValidators.validateTime(_selectedTime);

    if (_nameError == null &&
        _emailError == null &&
        _email2Error == null &&
        _passwordError == null &&
        _phoneError == null &&
        _countryError == null &&
        _hobbiesError == null &&
        _genderError == null &&
        _birthDateError == null &&
        _timeError == null
    ) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Form submitted successfully!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      _nameController.clear();
      _emailController.clear();
      _email2Controller.clear();
      _passwordController.clear();
      _phoneController.value = PhoneNumber(isoCode: IsoCode.LK, nsn: '');
      _phoneSuffixController.value = PhoneNumber(isoCode: IsoCode.LK, nsn: '');
      _selectedCountryKey = null;
      _selectedHobbies.clear();
      _selectedGender = null;
      _selectedBirthDate = null;
      _selectedTime = null;

      setState(() {
        _nameError = null;
        _emailError = null;
        _email2Error = null;
        _passwordError = null;
        _phoneError = null;
        _countryError = null;
        _hobbiesError = null;
        _genderError = null;
        _birthDateError = null;
        _timeError = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Example Form Fields',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomTextField(
                      label: 'Full Name',
                      hint: 'Enter your full name',
                      controller: _nameController,
                      errorMsg: _nameError,
                      keyboardType: TextInputType.name,
                      onChanged: _onNameChanged,
                    ),
                    CustomTextField(
                      label: 'Email',
                      isOptionalMark: true,
                      hint: 'Enter your email',
                      controller: _emailController,
                      prefixIcon: const Icon(Icons.email),
                      errorMsg: _emailError,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: _onEmailChanged,
                    ),
                    CustomTextField(
                      label: 'Password',
                      hint: 'Enter your password',
                      controller: _passwordController,
                      prefixIcon: const Icon(Icons.lock),
                      errorMsg: _passwordError,
                      obscureText: true,
                      onChanged: _onPasswordChanged,
                    ),
                    CustomPhoneTextField(
                      label: 'Phone Number',
                      controller: _phoneController,
                      errorMsg: _phoneError,
                      isOptionalMark: true,
                      onChanged: _onPhoneChanged,
                    ),
                    CustomPhoneTextFieldWithButton(
                      label: 'Phone Number',
                      controller: _phoneSuffixController,
                      buttonText: 'Verify',
                      onChanged: _onPhoneSuffixChanged,
                      onButtonPressed: () {
                        // Handle verification
                      },
                      buttonColor: Colors.blue,
                      errorMsg: _phoneSuffixError,
                    ),
                    CustomTextFieldWithButton(
                      label: 'Email',
                      hint: 'Enter your email',
                      controller: _email2Controller,
                      buttonText: 'Verify',
                      onChanged: _onEmail2Changed,
                      errorMsg: _email2Error,
                      onButtonPressed: () {
                        print('Verify clicked');
                      },
                    ),
                    CustomDropdownField(
                      label: 'Country',
                      hint: 'Select your country',
                      items: _countries,
                      selectedKey: _selectedCountryKey,
                      // prefixIcon: const Icon(Icons.public),
                      errorMsg: _countryError,
                      isOptionalMark: true,
                      onChanged: _onCountryChanged,
                    ),
                    CustomCheckboxGroup(
                      label: 'Select Your Hobbies (Min 2)',
                      items: _hobbies,
                      selectedKeys: _selectedHobbies,
                      onChanged: _onHobbiesChanged,
                      errorMsg: _hobbiesError,
                      // showSelectAll: true,
                      isOptionalMark: true,
                      layout: CheckboxGroupLayout.vertical,
                    ),
                    CustomRadioGroup(
                      label: 'Gender',
                      items: _genders,
                      selectedKey: _selectedGender,
                      onChanged: _onGenderChanged,
                      errorMsg: _genderError,
                      isOptionalMark: true,
                      layout: RadioGroupLayout.vertical,
                    ),
                    CustomDateField(
                      label: 'Date of Birth',
                      hint: 'Select your birth date',
                      selectedDate: _selectedBirthDate,
                      onChanged: _onBirthDateChanged,
                      errorMsg: _birthDateError,
                      // prefixIcon: const Icon(Icons.cake),
                      isOptionalMark: true,
                      lastDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      dateFormat: DateFormat('dd/MM/yyyy'),
                    ),
                    CustomTimeField(
                      label: 'Preferred Time',
                      hint: 'Select a time',
                      selectedTime: _selectedTime,
                      onChanged: _onTimeChanged,
                      errorMsg: _timeError,
                      isOptionalMark: true,
                      use24HourFormat: false,
                      initialEntryMode: TimePickerEntryMode.dial,
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: 'Submit',
                      onPressed: _submitForm,
                      isLoading: true,
                      backgroundColor: Colors.blue,
                      textColor: Colors.white,
                      height: 50,
                      borderRadius: 10,
                      fontSize: 18,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}