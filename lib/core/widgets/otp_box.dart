import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpBoxes extends StatelessWidget {
  const OtpBoxes({
    super.key,
    required this.controller,
    required this.isComplete,
  });

  final TextEditingController controller;
  final ValueNotifier<bool> isComplete;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
    );

    return Pinput(
      length: 6,
      controller: controller,
      keyboardType: TextInputType.number,
      autofillHints: const [AutofillHints.oneTimeCode],
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          border: Border.all(color: const Color(0xFF3B82F6), width: 2),
        ),
      ),
      onChanged: (value) {
        isComplete.value = value.trim().length == 6;
      },
      onCompleted: (code) {
        isComplete.value = true; // تلقائي أو يدوي
      },
    );
  }
}
