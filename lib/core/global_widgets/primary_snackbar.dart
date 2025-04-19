// ignore_for_file: non_constant_identifier_names

import 'package:dristi_open_source/core/styles/colors/colors.dart';
import 'package:flutter/material.dart';

class ShowSnackBarMessage {
  static void showSuccessSnackBar({
    required String message,
    required BuildContext context,
    int seconds = 2,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: seconds),
        content: Center(
          child: Text(
            message,
            style: TextStyle(color: UIColors.lightText(context), fontSize: 16),
          ),
        ),
        backgroundColor: UIColors.primaryComponent(context),
      ),
    );
  }

  static void showErrorSnackBar({
    required String message,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Center(
          child: Text(
            message,
            style: TextStyle(color: UIColors.lightText(context), fontSize: 16),
          ),
        ),
        backgroundColor: UIColors.errorText(context),
      ),
    );
  }

  static void showLoadingSnackBar({
    required String message,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Row(
          children: [
            Center(
              child: Text(
                message,
                style: TextStyle(
                  color: UIColors.lightText(context),
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: UIColors.primaryComponent(context),
      ),
    );
  }
}
