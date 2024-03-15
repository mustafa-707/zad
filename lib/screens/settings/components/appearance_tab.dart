import 'package:flutter/material.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:zad_app/components/direction_aware.dart';
import 'package:zad_app/utils/lang/locale.export.dart';

class AppearanceTab extends StatelessWidget {
  final String title;
  final IconData icon;
  final String? route;
  const AppearanceTab({
    super.key,
    required this.title,
    required this.icon,
    this.route,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final translate = AppLocalizations.of(context)!;

    return Column(
      children: [
        InkWell(
          onTap: () {
            if (route == null) return;
            Navigator.pushNamed(context, route!);
          },
          child: Container(
            height: 40,
            margin: const EdgeInsets.only(bottom: 16, top: 16, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                    ),
                    const SizedBox(width: 35),
                    Container(
                      // width: Get.width * 0.50,
                      margin: const EdgeInsets.only(top: 6),
                      child: Text(
                        title,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                route == null
                    ? Text(
                        translate.comingSoon,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.shadow.withOpacity(.5),
                        ),
                      )
                    : const DirectionAware(
                        child: Icon(
                          FrinoIcons.f_arrow_left,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
