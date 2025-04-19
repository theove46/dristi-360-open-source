import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dristi_open_source/core/enums/app_language.dart';
import 'package:dristi_open_source/core/global_providers/language_settings/language_settings_state.dart';
import 'package:dristi_open_source/core/global_providers/network_status/network_status_provider.dart';
import 'package:dristi_open_source/domain/repositories/app_repositories.dart';
import 'package:dristi_open_source/features/districts/providers/district_provider.dart';
import 'package:dristi_open_source/features/home/home_screen/providers/home_provider.dart';
import 'package:dristi_open_source/features/settings/providers/settings_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguageNotifier extends Notifier<LanguageState> {
  late AppRepository repository;

  @override
  LanguageState build() {
    repository = ref.read(appRepositoryProvider);
    return const LanguageState();
  }

  Future<void> loadInitialLanguageState() async {
    final language = await repository.loadInitialLanguageState();

    state = state.copyWith(language: language);
  }

  void setLanguage(AppLanguages language) {
    state = state.copyWith(language: language);

    repository.setLanguage(language);
  }

  void changeLanguage(AppLanguages language) async {
    state = state.copyWith(language: language);

    repository.setLanguage(language);

    await _getHomeComponents(language.toLanguage.languageCode);
  }

  /// TODO  Make a common Get Home Components
  Future<void> _getHomeComponents(String appLanguage) async {
    final state = ref.watch(networkStatusProvider);
    const isRefresh = true;

    if (state.data?.first != ConnectivityResult.none) {
      ref
          .read(sliderProvider.notifier)
          .getSliderComponents(appLanguage: appLanguage, isRefresh: isRefresh);
      ref
          .read(categoriesProvider.notifier)
          .getCategoriesComponents(
            appLanguage: appLanguage,
            isRefresh: isRefresh,
          );
      ref
          .read(topDestinationsProvider.notifier)
          .topDestinationsComponents(
            appLanguage: appLanguage,
            isRefresh: isRefresh,
          );
      ref
          .read(popularDistrictProvider.notifier)
          .getPopularDistrictComponents(
            appLanguage: appLanguage,
            isRefresh: isRefresh,
          );
      ref
          .read(settingsProvider.notifier)
          .getSettingsComponents(
            appLanguage: appLanguage,
            isRefresh: isRefresh,
          );
      ref.read(districtProvider.notifier).getDistrictComponents(appLanguage);
      ref
          .read(multipleAdvertisementProvider.notifier)
          .getMultipleAdvertisementComponents();
    }
  }
}
