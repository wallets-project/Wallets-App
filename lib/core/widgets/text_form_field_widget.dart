import 'package:flutter/material.dart';

class FieldWidget extends StatefulWidget {
  const FieldWidget({
    super.key,
    required this.label,
    required this.controller,
    this.hintText,
    this.keyboardType,
    this.prefixIcon,
    this.isPassword = false,
    this.validator,
    this.onChanged,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  final String label;
  final TextEditingController controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final bool isPassword;

  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;

  @override
  State<FieldWidget> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<FieldWidget> {
  bool _obscure = true;

  @override
  void initState() {
    super.initState();
    _obscure = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.label,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: const Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 10),

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
          ),
          child: TextFormField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            obscureText: widget.isPassword ? _obscure : false,
            validator: widget.validator,
            onChanged: widget.onChanged,
            textInputAction: widget.textInputAction,
            onFieldSubmitted: widget.onFieldSubmitted,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF111827),
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
              prefixIcon: widget.prefixIcon == null
                  ? null
                  : Icon(widget.prefixIcon, color: const Color(0xFF9CA3AF)),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      onPressed: () => setState(() => _obscure = !_obscure),
                      icon: Icon(
                        _obscure ? Icons.visibility_off : Icons.visibility,
                        color: const Color(0xFF9CA3AF),
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
