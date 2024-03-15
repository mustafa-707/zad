import 'package:flutter/material.dart';

class ValidationTextField extends StatelessWidget {
  final String? Function(String?) validator;
  final String hintText;
  final bool obscureText;
  final bool enabled;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;

  const ValidationTextField({
    super.key,
    required this.validator,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.enabled = true,
    this.suffixIcon,
    this.focusNode,
    this.textInputAction = TextInputAction.next,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.zero,
      child: TextFormField(
        focusNode: focusNode,
        controller: controller,
        enabled: enabled,
        validator: validator,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        style: theme.textTheme.bodyMedium,
        obscureText: obscureText,
        decoration: InputDecoration(
          fillColor: Colors.black,
          hintText: hintText,
          suffixIcon: suffixIcon,
          errorStyle: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onError,
          ),
          hintStyle: theme.textTheme.bodyMedium,
          focusedBorder: _border(theme),
          enabledBorder: _border(theme),
          border: _border(theme),
          disabledBorder: _border(theme),
          errorBorder: _errorBorder(theme),
          focusedErrorBorder: _errorBorder(theme),
        ),
      ),
    );
  }

  OutlineInputBorder _border(ThemeData theme) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(0.0),
      borderSide: BorderSide(
        color: theme.colorScheme.shadow,
      ),
    );
  }

  OutlineInputBorder _errorBorder(ThemeData theme) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(0.0),
      borderSide: BorderSide(
        color: theme.colorScheme.onError,
      ),
    );
  }
}
