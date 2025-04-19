import 'package:dristi_open_source/core/styles/texts/texts.dart';
import 'package:dristi_open_source/core/styles/themes/icon_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBarTheme extends AppBarTheme {
  final ColorScheme scheme;

  CustomAppBarTheme({
    required this.scheme,
  }) : super(
          backgroundColor: scheme.surface,
          foregroundColor: scheme.primary,
          surfaceTintColor: scheme.surfaceTint,
          elevation: 0,
          titleSpacing: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: scheme.primary,
            fontWeight: FontWeight.w700,
            fontFamily: FontFamily.nunito,
            fontSize: 16.sp,
          ),
          iconTheme: CustomIconTheme(
            scheme: scheme,
          ),
        );
}
