import 'package:flutter/material.dart';

class LineWidget extends StatelessWidget {
  const LineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.colorScheme.shadow,
      margin: const EdgeInsets.only(left: 20, right: 25),
      height: 0.1,
    );
  }
}
