import 'package:flutter/material.dart';

class PrimaryTextField extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusCurrent;
  final FocusNode? focusNext;
  final TextInputAction keyboardAction;
  final Widget? suffixWidget;
  final bool isVisible;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final Widget? prefixIcon;
  final void Function(String)? onFieldSubmitted;

  static const double borderRadius = 8.0;

  const PrimaryTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.focusCurrent,
    this.focusNext,
    this.autofocus = false,
    this.onChanged,
    this.prefixIcon,
    this.suffixWidget,
    this.keyboardAction = TextInputAction.done,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.isVisible = false,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 48,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius),
        ),
      ),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onPrimary,
        ),
        obscureText: isVisible,
        focusNode: focusCurrent,
        validator: validator,
        onFieldSubmitted: (term) {
          onFieldSubmitted?.call(term.trim());
          _handleFieldFocusChange(
            context,
            focusCurrent,
            focusNext,
          );
        },
        cursorColor: theme.colorScheme.onPrimary,
        onChanged: onChanged,
        autofocus: autofocus,
        textInputAction: keyboardAction,
        autocorrect: false,
        decoration: InputDecoration(
          counterText: '',
          contentPadding: const EdgeInsetsDirectional.only(start: 16),
          hintText: hintText,
          hintStyle: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onPrimary,
          ),
          suffixIconConstraints: const BoxConstraints(maxHeight: double.infinity),
          suffixIcon: suffixWidget,
          prefixIcon: prefixIcon,
          prefixIconConstraints: const BoxConstraints(maxHeight: 24, maxWidth: 40),
          errorMaxLines: 1,
          errorStyle: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onPrimary,
            height: 0.8,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(borderRadius),
            ),
            borderSide: BorderSide(
              width: 1,
              color: theme.colorScheme.onPrimary,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(borderRadius),
            ),
            borderSide: BorderSide(
              width: 1,
              color: theme.colorScheme.error,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(borderRadius),
            ),
            borderSide: BorderSide(
              width: 1,
              color: theme.colorScheme.error,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(borderRadius),
            ),
            borderSide: BorderSide(
              width: 1,
              color: theme.colorScheme.onPrimary,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(borderRadius),
            ),
            borderSide: BorderSide(
              width: 1,
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }

  _handleFieldFocusChange(
    BuildContext ctx,
    FocusNode? currentFocus,
    FocusNode? nextFocus,
  ) {
    if (currentFocus == nextFocus) {
      currentFocus?.unfocus();
    } else {
      currentFocus?.unfocus();
      FocusScope.of(ctx).requestFocus(nextFocus);
    }
  }
}
