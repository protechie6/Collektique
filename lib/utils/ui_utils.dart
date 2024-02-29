import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../ui/pages/account/upgrade/account_upgrade.dart';
import '../ui/widgets/text.dart';
import 'all_constants.dart';

class UiUtils {
  static String? validateEmail(String email) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(email)) {
      return 'Please enter an email.';
    } else {
      return null;
    }
  }

  static String? validatePassword(String password) {
    if (password.trim().length < 8) {
      return 'Password is too short! Minimum length is 8.';
    } else {
      return null;
    }
  }

  static bool _isNumeric(String s) {
    for (int i = 0; i < s.length; i++) {
      if (double.tryParse(s[i]) != null) {
        return true;
      }
    }
    return false;
  }

  static String? validateName(String s) {
    if (_isNumeric(s)) {
      return 'Invalid Name!';
    }
    if (s.isEmpty) {
      return 'Don\'t forget the name!';
    }
    return null;
  }

  static String currencySymbol(BuildContext context, String name) {
    Localizations.localeOf(context);
    var format =
        NumberFormat.simpleCurrency(locale: Platform.localeName, name: name);
    return format.currencySymbol;
  }

  static customSnackBar(BuildContext context,
      {required String msg,
      double height = 50,
      Color backgroundColor = AppColors.buttonColor1}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final snackBar = SnackBar(
      backgroundColor: backgroundColor,
      content: customText(msg, fontSize: 14.0, textColor: AppColors.white),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void upgradeAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Upgrade account"),
        content: const Text(
          "Please ugrade your account to continue to enjoy more of ${AppConstants.appName} service.",
          style: TextStyle(
            color: AppColors.backgroundColor,
            fontFamily: 'Poppins',
            fontSize: 16,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.0,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Container(
              color: AppColors.white,
              padding: const EdgeInsets.all(15),
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: AppColors.buttonColor1,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.bold,
                  height: 1.0,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AccountUpgrade()));
            },
            child: Container(
              color: AppColors.white,
              padding: const EdgeInsets.all(15),
              child: const Text(
                "Upgrade",
                style: TextStyle(
                  color: AppColors.backgroundColor,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.bold,
                  height: 1.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
