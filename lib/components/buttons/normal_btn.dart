import 'package:flutter/material.dart';

class NormalButton extends StatelessWidget {
  final String text;
  final GestureTapCallback onPressed;
  final double width;

  const NormalButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = 165,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: width,
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
