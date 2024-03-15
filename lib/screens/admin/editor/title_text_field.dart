import 'package:flutter/material.dart';

class ArticleTitleTextField extends StatelessWidget {
  final TextEditingController controller;
  const ArticleTitleTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 162,
      child: TextFormField(
        controller: controller,
        style: theme.textTheme.bodyLarge?.copyWith(height: 1.2, fontSize: 24),
        maxLines: 4,
        minLines: 1,
        keyboardType: TextInputType.multiline,
        autocorrect: false,
        decoration: InputDecoration(
          counterText: '',
          hintText: 'Type Something...',
          labelStyle: theme.textTheme.bodyLarge?.copyWith(height: 1.2, fontSize: 24),
          hintStyle: theme.textTheme.bodyLarge,
          errorMaxLines: 1,
          errorStyle: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onError,
            height: 0.8,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Colors.transparent,
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
