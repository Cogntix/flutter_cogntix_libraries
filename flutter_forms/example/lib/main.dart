import 'package:flutter/material.dart';
import 'package:flutter_forms/flutter_forms.dart';
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
  final _email2Controller = TextEditingController();

  String? _nameError;
  String? _emailError;
  String? _email2Error;
  String? _passwordError;
  String? _phoneError;
  String? _phoneSuffixError;

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

  void _submitForm() {
    setState(() {
      _nameError = FormValidators.validateName(_nameController.text);
      _emailError = FormValidators.validateEmail(_emailController.text);
      _email2Error = FormValidators.validateEmail(_email2Controller.text);
      _passwordError = FormValidators.validatePassword(_passwordController.text);
      _phoneError = FormValidators.validatePhone(_phoneController.value);
      _phoneSuffixError = FormValidators.validatePhone(_phoneSuffixController.value);
    });

    if (_nameError == null &&
        _emailError == null &&
        _email2Error == null &&
        _passwordError == null &&
        _phoneError == null) {
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

      setState(() {
        _nameError = null;
        _emailError = null;
        _email2Error = null;
        _passwordError = null;
        _phoneError = null;
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
                      'Registration Form',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomTextField(
                      label: 'Full Name',
                      labelStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      hint: 'Enter your full name',
                      controller: _nameController,
                      prefixIcon: const Icon(Icons.person),
                      errorMsg: _nameError,
                      keyboardType: TextInputType.name,
                      onChanged: _onNameChanged,
                    ),
                    CustomTextField(
                      label: 'Email',
                      labelStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      hint: 'Enter your email',
                      controller: _emailController,
                      prefixIcon: const Icon(Icons.email),
                      errorMsg: _emailError,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: _onEmailChanged,
                    ),
                    CustomTextField(
                      label: 'Password',
                      labelStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
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

                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
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