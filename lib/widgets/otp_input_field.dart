import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpInputField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final FocusNode? previousFocusNode;
  final Function(String)? onChanged;

  const OtpInputField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.nextFocusNode,
    this.previousFocusNode,
    this.onChanged,
  });

  @override
  State<OtpInputField> createState() => _OtpInputFieldState();
}

class _OtpInputFieldState extends State<OtpInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: widget.controller.text.isNotEmpty
              ? Colors.blue.shade400
              : Colors.grey.shade200,
          width: 1.5,
        ),
      ),
      child: Center(
        child: TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          obscureText: widget.controller.text.isNotEmpty,
          obscuringCharacter: '•',
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          decoration: const InputDecoration(
            counterText: '',
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (value) {
            setState(() {}); // Update border color and obscure text

            if (value.isNotEmpty) {
              // Move to next field
              if (widget.nextFocusNode != null) {
                widget.nextFocusNode!.requestFocus();
              }
            } else {
              // Move to previous field on delete
              if (widget.previousFocusNode != null) {
                widget.previousFocusNode!.requestFocus();
              }
            }

            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
        ),
      ),
    );
  }
}
