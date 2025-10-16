import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/circular_back_button.dart';
import '../widgets/otp_input_field.dart';
import '../widgets/success_dialog.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String email;

  const VerifyCodeScreen({super.key, required this.email});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final _otp1Controller = TextEditingController();
  final _otp2Controller = TextEditingController();
  final _otp3Controller = TextEditingController();
  final _otp4Controller = TextEditingController();

  final _otp1FocusNode = FocusNode();
  final _otp2FocusNode = FocusNode();
  final _otp3FocusNode = FocusNode();
  final _otp4FocusNode = FocusNode();

  int _remainingSeconds = 48;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
    // Auto-focus first field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _otp1FocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _otp1Controller.dispose();
    _otp2Controller.dispose();
    _otp3Controller.dispose();
    _otp4Controller.dispose();
    _otp1FocusNode.dispose();
    _otp2FocusNode.dispose();
    _otp3FocusNode.dispose();
    _otp4FocusNode.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _resendCode() {
    setState(() {
      _remainingSeconds = 48;
      _otp1Controller.clear();
      _otp2Controller.clear();
      _otp3Controller.clear();
      _otp4Controller.clear();
    });
    _startTimer();
    _otp1FocusNode.requestFocus();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Verification code sent!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _checkOtpAndProceed() {
    final otp =
        _otp1Controller.text +
        _otp2Controller.text +
        _otp3Controller.text +
        _otp4Controller.text;

    if (otp.length == 4) {
      // Show success dialog
      SuccessDialog.show(
        context: context,
        title: 'Password Reset Successful',
        message:
            'Your password has been reset successfully. You can now sign in with your new password.',
        buttonText: 'Continue',
        imagePath: 'lib/assets/images/list-3.png',
        onContinue: () {
          Navigator.of(context).pop(); // Close dialog
          Navigator.of(
            context,
          ).popUntil((route) => route.isFirst); // Go back to sign in
        },
      );
    }
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
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
                      'Verify Code',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Subtitle with email
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                            height: 1.5,
                          ),
                          children: [
                            const TextSpan(
                              text:
                                  'Please enter the code we just sent to email ',
                            ),
                            TextSpan(
                              text: widget.email,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 60),

                  // OTP Input Fields
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OtpInputField(
                        controller: _otp1Controller,
                        focusNode: _otp1FocusNode,
                        nextFocusNode: _otp2FocusNode,
                        onChanged: (_) => _checkOtpAndProceed(),
                      ),
                      const SizedBox(width: 16),
                      OtpInputField(
                        controller: _otp2Controller,
                        focusNode: _otp2FocusNode,
                        nextFocusNode: _otp3FocusNode,
                        previousFocusNode: _otp1FocusNode,
                        onChanged: (_) => _checkOtpAndProceed(),
                      ),
                      const SizedBox(width: 16),
                      OtpInputField(
                        controller: _otp3Controller,
                        focusNode: _otp3FocusNode,
                        nextFocusNode: _otp4FocusNode,
                        previousFocusNode: _otp2FocusNode,
                        onChanged: (_) => _checkOtpAndProceed(),
                      ),
                      const SizedBox(width: 16),
                      OtpInputField(
                        controller: _otp4Controller,
                        focusNode: _otp4FocusNode,
                        previousFocusNode: _otp3FocusNode,
                        onChanged: (_) => _checkOtpAndProceed(),
                      ),
                    ],
                  ),

                  const SizedBox(height: 120),

                  // Resend code timer
                  Center(
                    child: _remainingSeconds > 0
                        ? RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade600,
                              ),
                              children: [
                                const TextSpan(text: 'Resend code in '),
                                TextSpan(
                                  text: _formatTime(_remainingSeconds),
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : TextButton(
                            onPressed: _resendCode,
                            child: Text(
                              'Resend Code',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue.shade600,
                              ),
                            ),
                          ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
