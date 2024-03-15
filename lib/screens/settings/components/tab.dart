import 'package:flutter/material.dart';

class SettingsTab extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final GestureTapCallback onTap;

  const SettingsTab({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 22),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 32),
            subtitle == null
                ? Text(
                    title,
                    style: theme.textTheme.titleMedium,
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        subtitle ?? "",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.primary.withOpacity(.4),
                        ),
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
