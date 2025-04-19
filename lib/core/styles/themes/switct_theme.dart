import 'package:flutter/material.dart';

class CustomSwitchTheme extends SwitchThemeData {
  final ColorScheme scheme;

  CustomSwitchTheme({
    required this.scheme,
  }) : super(
          thumbColor: WidgetStateProperty.resolveWith((states) {
            return scheme.primary;
          }),
          trackColor: WidgetStateProperty.resolveWith((states) {
            return scheme.surface;
          }),
          trackOutlineColor: WidgetStateProperty.resolveWith((states) {
            return scheme.primary;
          }),
          trackOutlineWidth: WidgetStateProperty.resolveWith((states) {
            return 1;
          }),
        );
}
