import 'package:flutter/material.dart';

class AppProgressIndicator extends StatelessWidget {
  const AppProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        Center(
          child: Container(
            height: 61,
            width: 61,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: const BorderRadius.all(
                Radius.circular(100),
              ),
              border: Border.all(
                color: theme.colorScheme.secondary,
              ),
            ),
          ),
        ),
        Center(
          child: SizedBox(
            height: 60,
            width: 60,
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              color: theme.colorScheme.onSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
