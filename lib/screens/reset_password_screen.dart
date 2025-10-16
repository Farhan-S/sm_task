import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/circular_back_button.dart';
import '../widgets/password_text_field.dart';
import '../widgets/primary_button.dart';
import 'verify_code_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;

  const ResetPasswordScreen({super.key, required this.email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Password requirements
  bool _hasMinLength = false;
  bool _hasLetter = false;
  bool _hasNumber = false;

  bool get _isPasswordValid => _hasMinLength && _hasLetter && _hasNumber;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _checkPasswordRequirements(String password) {
    setState(() {
      _hasMinLength = password.length >= 8;
      _hasLetter = password.contains(RegExp(r'[a-zA-Z]'));
      _hasNumber = password.contains(RegExp(r'[0-9]'));
    });
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      // Navigate to OTP verification screen
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => VerifyCodeScreen(email: widget.email),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // Back button
                    const CircularBackButton(),

                    const SizedBox(height: 60),

                    // Title
                    const Center(
                      child: Text(
                        'Reset Password',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Subtitle
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Your password must be at least 8 characters long and include a combination of letters, numbers',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // New Password field
                    PasswordTextField(
                      label: 'New Password',
                      controller: _newPasswordController,
                      showStrengthIndicator: false,
                      onChanged: (value) {
                        _checkPasswordRequirements(value);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (!_isPasswordValid) {
                          return 'Password does not meet requirements';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 24),

                    // Confirm New Password field
                    PasswordTextField(
                      label: 'Confirm New Password',
                      controller: _confirmPasswordController,
                      showStrengthIndicator: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _newPasswordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 80),

                    // Submit button
                    PrimaryButton(text: 'Submit', onPressed: _handleSubmit),

                    const SizedBox(height: 40),
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
