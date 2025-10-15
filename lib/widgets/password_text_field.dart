import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool showStrengthIndicator;

  const PasswordTextField({
    super.key,
    required this.label,
    this.hintText = '••••••••',
    this.controller,
    this.validator,
    this.onChanged,
    this.showStrengthIndicator = false,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;
  String _password = '';

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  double _getPasswordStrength() {
    if (_password.isEmpty) return 0;

    int strength = 0;
    if (_password.length >= 8) strength++;
    if (_password.contains(RegExp(r'[a-z]'))) strength++;
    if (_password.contains(RegExp(r'[A-Z]'))) strength++;
    if (_password.contains(RegExp(r'[0-9]'))) strength++;
    if (_password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength++;

    return strength / 5;
  }

  String _getStrengthText() {
    double strength = _getPasswordStrength();
    if (strength <= 0.2) return 'Weak';
    if (strength <= 0.6) return 'Medium';
    return 'Strong';
  }

  Color _getStrengthColor() {
    double strength = _getPasswordStrength();
    if (strength <= 0.2) return Colors.red;
    if (strength <= 0.6) return Colors.orange;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: widget.controller,
          obscureText: _obscureText,
          validator: widget.validator,
          onChanged: (value) {
            setState(() {
              _password = value;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
            letterSpacing: 2,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade400,
              letterSpacing: 2,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Colors.grey.shade400,
                size: 22,
              ),
              onPressed: _togglePasswordVisibility,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 18,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.blue.shade400, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
          ),
        ),

        // Password strength indicator - 5 bars
        if (widget.showStrengthIndicator && _password.isNotEmpty) ...[
          const SizedBox(height: 12),
          Row(
            children: [
              // Bar 1
              Expanded(
                flex: 1,
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: _getPasswordStrength() >= 0.2
                        ? _getStrengthColor()
                        : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              // Bar 2
              Expanded(
                flex: 1,
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: _getPasswordStrength() >= 0.4
                        ? _getStrengthColor()
                        : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              // Bar 3
              Expanded(
                flex: 1,
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: _getPasswordStrength() >= 0.6
                        ? _getStrengthColor()
                        : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              // Bar 4
              Expanded(
                flex: 1,
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: _getPasswordStrength() >= 0.8
                        ? _getStrengthColor()
                        : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              // Bar 5
              Expanded(
                flex: 1,
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: _getPasswordStrength() >= 1.0
                        ? _getStrengthColor()
                        : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                _getStrengthText(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _getStrengthColor(),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
