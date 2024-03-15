import 'package:flutter/material.dart';

class NormalButton extends StatelessWidget {
  final String text;
  final GestureTapCallback onPressed;
  const NormalButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: 165,
      height: 48,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
            theme.colorScheme.primary,
          ),
          shadowColor: const MaterialStatePropertyAll(
            Colors.transparent,
          ),
        ),
        onPressed: () {
          onPressed();
        },
        child: Text(
          text,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
