import 'package:dristi_open_source/core/global_providers/language_settings/language_settings_notifier.dart';
import 'package:dristi_open_source/core/global_providers/language_settings/language_settings_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final languageProvider = NotifierProvider<LanguageNotifier, LanguageState>(
  LanguageNotifier.new,
  name: 'languageProvider',
);

final currentDestinationLanguageProvider = StateProvider<String>(
  (ref) => '',
  name: 'currentDestinationLanguageProvider',
);
