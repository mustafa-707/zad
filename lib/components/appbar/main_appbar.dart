import 'package:flutter/material.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:zad_app/screens/content/language_picker/content_langauge_picker.dart';
import 'package:zad_app/utils/theme/images.dart';

class MainAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppbar({super.key});
  static const double kHeight = 66.0;
  static const double kRadius = 15.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateNow = HijriCalendar.now();

    return AppBar(
      backgroundColor: theme.colorScheme.primary,
      centerTitle: true,
      title: Image.asset(
        Images.appLogoLight,
        height: 60,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text(
                '${dateNow.hDay}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              Text(
                ' ${dateNow.longMonthName} ',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              Text(
                '${dateNow.hYear}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                FrinoIcons.f_calendar,
                color: theme.colorScheme.onPrimary,
                size: 18,
              ),
            ],
          ),
        ),
      ],
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const ContentLanguagePickerScreen.subPage(),
            ),
          );
        },
        icon: Icon(
          FrinoIcons.f_translate,
          color: theme.colorScheme.onPrimary,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
