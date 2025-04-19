import 'package:dristi_open_source/core/global_providers/theme_settings/theme_settings_notifier.dart';
import 'package:dristi_open_source/core/global_providers/theme_settings/theme_settings_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = NotifierProvider<ThemeNotifier, ThemeState>(
  ThemeNotifier.new,
  name: 'themeProvider',
);
