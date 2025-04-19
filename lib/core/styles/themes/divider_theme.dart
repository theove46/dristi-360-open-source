import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDividerTheme extends DividerThemeData {
  final ColorScheme scheme;

  CustomDividerTheme({
    required this.scheme,
  }) : super(
          color: scheme.outline,
          thickness: AppValues.dimen_1.h,
        );
}
