import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum AppLanguages { en, bn }

List<Locale> get supportedLanguages =>
    AppLanguages.values
        .map((AppLanguages language) => language.toLanguage)
        .toList();

extension AppLanguageExtension on AppLanguages {
  Locale get toLanguage => Locale(name);
}

extension LocalizationExtension on BuildContext {
  AppLocalizations get localization => AppLocalizations.of(this)!;
}
