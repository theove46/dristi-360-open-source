import 'package:dristi_open_source/features/settings/providers/settings_notifier.dart';
import 'package:dristi_open_source/features/settings/providers/settings_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsProvider = NotifierProvider<SettingsNotifier, SettingsState>(
  SettingsNotifier.new,
  name: 'settingsProvider',
);
