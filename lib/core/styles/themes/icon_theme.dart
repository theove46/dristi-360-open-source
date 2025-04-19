import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomIconTheme extends IconThemeData {
  final ColorScheme scheme;

  CustomIconTheme({required this.scheme})
    : super(color: scheme.primary, size: AppValues.dimen_30.r);
}
