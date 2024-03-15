import 'package:flutter/material.dart';
import 'package:zad_app/screens/settings/components/profile.dart';

class AppFloatingActionButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final IconData icon;
  final Widget? hero;

  const AppFloatingActionButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.hero,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        onPressed();
      },
      heroTag: const ProfileTab(),
      child: Icon(icon),
    );
  }
}
