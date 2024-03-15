import 'package:flutter/material.dart';
import 'package:zad_app/utils/lang/locale.export.dart';

Future<void> addCategoryTitleDialog(
  BuildContext context,
  TextEditingController controller,
  bool mounted, {
  required String title,
  required String hint,
  required String actionText,
  required Future Function() onTap,
}) async {
  final translate = AppLocalizations.of(context)!;

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
          ),
        ),
        actions: <Widget>[
          MaterialButton(
            color: Colors.red,
            textColor: Colors.white,
            child: Text(translate.cancel),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          MaterialButton(
            color: Colors.green,
            textColor: Colors.white,
            child: Text(actionText),
            onPressed: () async {
              await onTap();
              if (mounted) {
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              }
            },
          ),
        ],
      );
    },
  );
}

Future<void> warningDialog(
  BuildContext context, {
  required String title,
  required String subtitle,
  required String actionText,
  required Future Function() onTap,
}) async {
  final translate = AppLocalizations.of(context)!;

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(subtitle),
        actions: <Widget>[
          MaterialButton(
            color: Colors.red,
            textColor: Colors.white,
            child: Text(translate.cancel),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          MaterialButton(
            color: Colors.green,
            textColor: Colors.white,
            child: Text(actionText),
            onPressed: () async {
              Navigator.pop(context);
              await onTap();
            },
          ),
        ],
      );
    },
  );
}
