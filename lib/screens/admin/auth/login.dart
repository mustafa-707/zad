import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zad_app/components/appbar/sub_screen_appbar.dart';
import 'package:zad_app/components/buttons/normal_btn.dart';
import 'package:zad_app/components/snackbar.dart';
import 'package:zad_app/components/fields/text_field.dart';
import 'package:zad_app/providers/app_settings.dart';
import 'package:zad_app/screens/main_screen.dart';
import 'package:zad_app/utils/lang/locale.export.dart';
import 'package:zad_app/utils/theme/colors.dart';
import 'package:zad_app/utils/theme/images.dart';

class LoginScreen extends StatefulHookConsumerWidget {
  const LoginScreen({super.key});
  static const routeName = '/login';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final validitorKey = GlobalKey<FormState>();
  bool isPassShowed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final translate = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: SubScreenAppbar(title: translate.login),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 22),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                translate.loginText,
                style: theme.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 240,
              child: Images.loginWarning,
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: Form(
                key: validitorKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      translate.loginToZad,
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    ValidationTextField(
                      controller: emailController,
                      hintText: translate.email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        final email = value?.trim();

                        // Null or empty check
                        if (email?.isEmpty ?? true) {
                          return translate.pleaseEnterEmail;
                        }

                        // Regular expression for a valid email address
                        // This is a simple example and may not cover all edge cases
                        // You might want to use a more robust regular expression
                        String pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
                        RegExp regExp = RegExp(pattern);

                        // Check if the entered email matches the pattern
                        if (!regExp.hasMatch(email!)) {
                          return translate.pleaseEnterValidEmail;
                        }

                        // Return null if the email is valid
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    ValidationTextField(
                        controller: passwordController,
                        hintText: translate.password,
                        validator: (value) {
                          final password = value?.trim();
                          // Null or empty check
                          if (password?.isEmpty ?? true) {
                            return translate.pleaseEnterPassword;
                          }
                          // Return null if the password is valid
                          return null;
                        },
                        obscureText: isPassShowed ? false : true,
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              isPassShowed = !isPassShowed;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(
                              top: 10,
                              bottom: 10,
                              end: 5,
                            ),
                            child: Icon(
                              isPassShowed ? FrinoIcons.f_eye : FrinoIcons.f_eye_slash,
                            ),
                          ),
                        )),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Expanded(child: SizedBox()),
                        InkWell(
                          onTap: () {
                            _launchUrl('https://forms.gle/qAdcK8j28dLRwYzq5');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              translate.beDaiyah,
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: AppColors.ancor,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 42),
            NormalButton(
              text: translate.login,
              onPressed: () async {
                if (validitorKey.currentState!.validate()) {
                  final login = await ref.read(appSettingsProvider.notifier).adminLogin(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );

                  if (login.isRight() && mounted) {
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const MainScreen(),
                      ),
                    );
                  } else {
                    // show error message `login`
                    log("error message on login $login");
                    showErrorMsg(
                      login.getLeft().toNullable()?.toString() ?? translate.unknownErrorOccurred,
                    );
                  }
                }
              },
            ),
            const SizedBox(height: 82),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
