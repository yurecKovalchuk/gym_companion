import 'package:flutter/material.dart';
import 'package:timer_bloc/localization/localization.dart';

class PrivacyPolicyDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(context.l10n.titlePrivacyPolicy),
          content: SingleChildScrollView(
            child: Text(
              context.l10n.textPrivacyPolicy,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(context.l10n.textButtonClose),
            ),
          ],
        );
      },
    );
  }
}