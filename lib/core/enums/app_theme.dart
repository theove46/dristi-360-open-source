import 'package:dristi_open_source/core/styles/themes/app_theme.dart';
import 'package:flutter/material.dart';

enum AppTheme { systemDefault, dark, light }

ThemeData getLightThemeData(AppTheme themeType) {
  switch (themeType) {
    case AppTheme.systemDefault:
      return AppThemeData.lightTheme;
    case AppTheme.light:
      return AppThemeData.lightTheme;
    case AppTheme.dark:
      return AppThemeData.darkTheme;
  }
}

ThemeData getDarkThemeData(AppTheme themeType) {
  switch (themeType) {
    case AppTheme.systemDefault:
      return AppThemeData.darkTheme;
    case AppTheme.light:
      return AppThemeData.lightTheme;
    case AppTheme.dark:
      return AppThemeData.darkTheme;
  }
}
