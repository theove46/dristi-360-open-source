import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButtonTheme extends ButtonStyle {
  final ColorScheme scheme;

  CustomElevatedButtonTheme({required this.scheme})
    : super(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled) ||
              states.contains(WidgetState.selected)) {
            return scheme.onSurface;
          } else {
            return scheme.shadow;
          }
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return scheme.onSurface;
          } else {
            return scheme.shadow;
          }
        }),
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled) ||
              states.contains(WidgetState.selected)) {
            return scheme.onSurface;
          } else {
            return scheme.shadow;
          }
        }),
        animationDuration: const Duration(milliseconds: 100),
        minimumSize: WidgetStatePropertyAll(
          Size(double.infinity, AppValues.dimen_48.r),
        ),
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(
            vertical: AppValues.dimen_16.r,
            horizontal: AppValues.dimen_16.r,
          ),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppValues.dimen_16.r),
          ),
        ),
      );
}
