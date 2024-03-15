import 'package:flutter/material.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:zad_app/components/appbar/main_appbar.dart';
import 'package:zad_app/components/buttons/floating_btn.dart';
import 'package:zad_app/screens/home/home_screen.dart';
import 'package:zad_app/screens/settings/settings_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  static const routeName = '/main';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppbar(),
      floatingActionButton: AppFloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            SettingsScreen.routeName,
          );
        },
        icon: FrinoIcons.f_settings,
      ),
      body: const HomeScreen(),
    );
  }
}
