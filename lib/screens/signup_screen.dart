import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/circular_back_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/password_text_field.dart';
import '../widgets/primary_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  // Password strength requirements
  bool _hasMinLength = false;
  bool _hasUppercase = false;
  bool _hasLowercase = false;
  bool _hasNumber = false;
  bool _hasSpecialChar = false;

  // Only minimum requirement is mandatory: 8 chars
  bool get _isMandatoryRequirementMet => _hasMinLength;

  bool get _isPasswordStrong =>
      _hasMinLength &&
      _hasUppercase &&
      _hasLowercase &&
      _hasNumber &&
      _hasSpecialChar;

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    if (_formKey.currentState!.validate()) {
      // Handle sign up logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account created successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _navigateToSignIn() {
    Navigator.of(context).pop();
  }

  void _checkPasswordStrength(String password) {
    setState(() {
      _hasMinLength = password.length >= 8;
      _hasUppercase = password.contains(RegExp(r'[A-Z]'));
      _hasLowercase = password.contains(RegExp(r'[a-z]'));
      _hasNumber = password.contains(RegExp(r'[0-9]'));
      _hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    });
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

                    const SizedBox(height: 30),

                    // Title
                    const Text(
                      'Welcome to Eduline',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Subtitle
                    Text(
                      'Let\'s join to Eduline learning ecosystem & meet our professional mentor. It\'s Free!',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Email field
                    CustomTextField(
                      label: 'Email Address',
                      hintText: 'pristia@gmail.com',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 24),

                    // Full name field
                    CustomTextField(
                      label: 'Full Name',
                      hintText: 'Pristia Candra',
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name';
                        }
                        if (value.length < 3) {
                          return 'Name must be at least 3 characters';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 24),

                    // Password field with strength indicator
                    PasswordTextField(
                      label: 'Password',
                      controller: _passwordController,
                      showStrengthIndicator: true,
                      onChanged: (value) {
                        _checkPasswordStrength(value);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (!_isMandatoryRequirementMet) {
                          return 'At least 8 characters with a combination of letters and numbers';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Mandatory requirement - shown prominently
                    _buildPasswordRequirement(
                      'At least 8 characters with a combination of letters and numbers',
                      _isMandatoryRequirementMet,
                    ),

                    const SizedBox(height: 32),

                    // Sign up button - enabled when mandatory requirement is met
                    Opacity(
                      opacity: _isMandatoryRequirementMet ? 1.0 : 0.5,
                      child: PrimaryButton(
                        text: 'Sign Up',
                        onPressed: _isMandatoryRequirementMet
                            ? _handleSignUp
                            : () {},
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Sign in link
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account? ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          TextButton(
                            onPressed: _navigateToSignIn,
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue.shade600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

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

  Widget _buildPasswordRequirement(String text, bool isMet) {
    return Row(
      children: [
        Icon(
          isMet ? Icons.check_circle : Icons.check_circle_outline,
          size: 20,
          color: isMet ? Colors.green : Colors.grey.shade400,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: isMet ? Colors.green : Colors.grey.shade600,
            ),
          ),
        ),
      ],
    );
  }
}
