import 'package:dristi_open_source/core/base/base_consumer_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/core/enums/app_language.dart';
import 'package:dristi_open_source/core/enums/app_theme.dart';
import 'package:dristi_open_source/core/global_providers/language_settings/language_settings_provider.dart';
import 'package:dristi_open_source/core/global_providers/theme_settings/theme_settings_provider.dart';
import 'package:dristi_open_source/core/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends BaseConsumerStatefulWidget<App> {
  @override
  void initState() {
    super.initState();
    ref.read(themeProvider.notifier).loadInitialThemeState();
    ref.read(languageProvider.notifier).loadInitialLanguageState();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = ref.watch(themeProvider);
    final languageState = ref.watch(languageProvider);

    return ScreenUtilInit(
      designSize: const Size(
        AppValues.dimenDefaultWidth,
        AppValues.dimenDefaultHeight,
      ),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp.router(
          routerConfig: appRouter,
          debugShowCheckedModeBanner: false,
          theme: getLightThemeData(themeState.data),
          darkTheme: getDarkThemeData(themeState.data),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: supportedLanguages,
          locale: languageState.language.toLanguage,
        );
      },
    );
  }
}
