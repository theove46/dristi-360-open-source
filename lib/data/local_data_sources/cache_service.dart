import 'package:dristi_open_source/core/enums/app_language.dart';
import 'package:dristi_open_source/core/enums/app_theme.dart';
import 'package:dristi_open_source/data/local_data_sources/cache_service_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cacheServiceProvider = Provider<CacheService>(
  (ref) => CacheServiceImpl(),
);

abstract class CacheService {
  Future<void> setFirstTimeOnBoardingFalse();

  Future<bool> getFirstTimeOnBoardingStatus();

  Future<void> setTheme(AppTheme theme);

  Future<AppTheme> getTheme();

  Future<void> setLanguage(AppLanguages language);

  Future<AppLanguages> getLanguage();

  Future<void> setFavouritesItemsList(Set<String> favoritesList);

  Future<Set<String>> getFavouritesItemsList();

  Future<void> setSliderData(String sliderData);

  Future<String?> getSliderData();

  Future<void> setCategoriesData(String categoriesData);

  Future<String?> getCategoriesData();

  Future<void> setSingleAdvertisementData(String singleAdvertisementData);

  Future<String?> getSingleAdvertisementData();

  Future<void> setMultipleAdvertisementData(String multipleAdvertisementData);

  Future<String?> getMultipleAdvertisementData();

  Future<void> setPopularDistrictsData(String popularDistrictsData);

  Future<String?> getPopularDistrictsData();

  Future<void> setTopDestinationsData(String topDestinationsData);

  Future<String?> getTopDestinationsData();

  Future<void> setSettingsData(String settingsData);

  Future<String?> getSettingsData();

  Future<void> setDestinationsListData(String settingsData);

  Future<String?> getDestinationsListData();

  Future<DateTime?> getDestinationsListDataTime();

  Future<void> setAccommodationsListData(String settingsData);

  Future<String?> getAccommodationsListData();

  Future<DateTime?> getAccommodationsListDataTime();
}
