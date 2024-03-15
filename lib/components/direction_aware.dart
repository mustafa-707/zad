import 'package:flutter/material.dart';
import 'dart:math' as math;

class DirectionAware extends StatelessWidget {
  final Widget child;

  const DirectionAware({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final currentDirection = Directionality.of(context);

    return Transform.rotate(
      angle: currentDirection == TextDirection.ltr ? -math.pi : 0,
      child: child,
    );
  }
}
