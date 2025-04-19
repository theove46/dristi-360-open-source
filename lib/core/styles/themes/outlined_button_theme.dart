import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOutlinedButtonTheme extends ButtonStyle {
  final ColorScheme scheme;

  CustomOutlinedButtonTheme({required this.scheme})
      : super(
          side: WidgetStatePropertyAll(
            BorderSide(
              color: scheme.outline,
            ),
          ),
          backgroundColor: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.disabled) ||
                  states.contains(WidgetState.selected)) {
                return scheme.secondaryContainer;
              } else {
                return scheme.secondary;
              }
            },
          ),
          foregroundColor: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.disabled)) {
                return scheme.primaryContainer;
              } else {
                return scheme.primary;
              }
            },
          ),
          animationDuration: const Duration(milliseconds: 200),
          minimumSize: WidgetStatePropertyAll(
            Size(
              double.infinity,
              AppValues.dimen_48.r,
            ),
          ),
          padding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(
              vertical: AppValues.dimen_16.r,
              horizontal: AppValues.dimen_16.r,
            ),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppValues.dimen_16.r,
              ),
            ),
          ),
        );
}
