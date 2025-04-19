import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomInputDecorationTheme extends InputDecorationTheme {
  final ColorScheme scheme;

  CustomInputDecorationTheme({required this.scheme})
      : super(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            vertical: AppValues.dimen_16.r,
            horizontal: AppValues.dimen_16.r,
          ),
          errorStyle: TextStyle(
            fontSize: 12,
            letterSpacing: 0.1,
            fontWeight: FontWeight.w500,
            color: scheme.error,
          ),
          labelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.1,
            color: scheme.primary,
          ),
          hintStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.1,
            color: scheme.onPrimaryContainer,
          ),
          filled: true,
          fillColor: scheme.scrim,
          enabledBorder: getBorder(scheme),
          focusedBorder: getBorder(scheme),
          errorBorder: getBorder(scheme),
          suffixIconColor: scheme.primary,
        );
}

OutlineInputBorder getBorder(ColorScheme scheme) {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: scheme.scrim,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(
        AppValues.dimen_10.r,
      ),
    ),
  );
}
