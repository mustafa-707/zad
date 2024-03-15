import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:zad_app/utils/global_navigator.dart';
import 'package:zad_app/utils/helpers/exceptions.dart';
import 'package:zad_app/utils/lang/locale.export.dart';

void showSuccessMsg(String text) {
  _showSnackbar(
    text,
    color: const Color(0xFF43C489),
    textColor: Colors.white,
  );
}

void showErrorMsg(String text) {
  _showSnackbar(
    text,
    color: const Color(0xFFEF7373),
    textColor: Colors.white,
  );
}

void handleException(Object e) {
  final translate = AppLocalizations.of(getRootNavigator().context);

  if (kDebugMode) {
    print("An exception occurred: $e");
  }

  if (e is ApplicationException) {
    if (e.code == 'unknown') {
      showErrorMsg(translate?.unknownErrorOccurred ?? 'An unknown error occurred');
    } else {
      showErrorMsg(e.text);
    }
  } else {
    if (e is UnauthenticatedException) {
      showErrorMsg(translate?.unauthenticated ?? 'Unauthenticated');
    } else {
      showErrorMsg(translate?.unknownErrorOccurred ?? 'An unknown error occurred');
    }
  }
}

void _showSnackbar(
  String text, {
  required Color color,
  required Color textColor,
}) {
  final navigator = getRootNavigator();
  showTopSnackBar(
    navigator.overlay!,
    AppSnackBar(
      color: color,
      text: text,
      textColor: textColor,
    ),
    curve: Curves.easeInOut,
    reverseCurve: Curves.easeInOut,
    animationDuration: const Duration(milliseconds: 350),
    reverseAnimationDuration: const Duration(milliseconds: 350),
    displayDuration: const Duration(milliseconds: 3000),
  );
}

class AppSnackBar extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String text;

  const AppSnackBar({
    super.key,
    required this.color,
    required this.textColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: textColor,
                  fontSize: 13,
                ),
          ),
        ),
      ),
    );
  }
}
