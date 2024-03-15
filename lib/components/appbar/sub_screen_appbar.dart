import 'package:flutter/material.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:zad_app/components/direction_aware.dart';

class SubScreenAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  const SubScreenAppbar({
    super.key,
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: theme.colorScheme.background,
      actions: actions,
      leading: !Navigator.canPop(context)
          ? null
          : IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const DirectionAware(
                child: Icon(FrinoIcons.f_arrow_right),
              ),
            ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
