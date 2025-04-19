import 'package:dristi_open_source/core/enums/app_language.dart';
import 'package:dristi_open_source/core/enums/app_theme.dart';
import 'package:dristi_open_source/data/local_data_sources/cache_service.dart'
    show CacheService;
import 'package:hive_flutter/hive_flutter.dart';

class CacheServiceImpl implements CacheService {
  CacheServiceImpl();

  late Box box;

  static const String _appSettingsBox = 'appSettingsBox';
  static const String _themeBox = 'themeBox';
  static const String _languageBox = 'languageBox';
  static const String _favoritesBox = 'favoritesBox';
  static const String _sliderBox = 'sliderBox';
  static const String _categoriesBox = 'categoriesBox';
  static const String _singleAdvertisementBox = 'singleAdvertisementBox';
  static const String _multipleAdvertisementBox = 'multipleAdvertisementBox';
  static const String _popularDistrictsBox = 'popularDistrictsBox';
  static const String _topDestinationsBox = 'topDestinationsBox';
  static const String _settingsBox = 'settingsBox';
  static const String _destinationsListBox = 'destinationsListBox';
  static const String _accommodationsListBox = 'accommodationsListBox';

  static const String _isFirstTimeKey = 'isFirstTime';
  static const String _themeKey = 'theme';
  static const String _languageKey = 'language';
  static const String _favoritesKey = 'favorites';
  static const String _sliderDataKey = 'sliderData';
  static const String _categoriesDataKey = 'categoriesData';
  static const String _singleAdvertisementDataKey = 'singleAdvertisementData';
  static const String _multipleAdvertisementDataKey =
      'multipleAdvertisementData';
  static const String _popularDistrictsDataKey = 'popularDistrictsData';
  static const String _topDestinationsDataKey = 'topDestinationsData';
  static const String _settingsDataKey = 'settingsData';
  static const String _destinationsListDataKey = 'destinationsListData';
  static const String _accommodationsListDataKey = 'accommodationsListData';

  static const String _destinationsListTimeKey = 'destinationsListTime';
  static const String _accommodationsListTimeKey = 'accommodationsListTime';

  @override
  Future<void> setFirstTimeOnBoardingFalse() async {
    Hive.openBox(_appSettingsBox);
    final box = Hive.box<bool>(_appSettingsBox);
    await box.put(_isFirstTimeKey, false);
  }

  @override
  Future<bool> getFirstTimeOnBoardingStatus() async {
    final box = await Hive.openBox<bool>(_appSettingsBox);
    bool? isFirstTime = box.get(_isFirstTimeKey);
    return isFirstTime ?? true;
  }

  @override
  Future<void> setTheme(AppTheme theme) async {
    Hive.openBox(_themeBox);
    final box = await Hive.openBox<int>(_themeBox);
    await box.put(_themeKey, theme.index);
  }

  @override
  Future<AppTheme> getTheme() async {
    final box = await Hive.openBox<int>(_themeBox);
    int? themeIndex = box.get(_themeKey);
    return AppTheme.values[themeIndex ?? AppTheme.systemDefault.index];
  }

  @override
  Future<void> setLanguage(AppLanguages language) async {
    final box = await Hive.openBox<int>(_languageBox);
    await box.put(_languageKey, language.index);
  }

  @override
  Future<AppLanguages> getLanguage() async {
    final box = await Hive.openBox<int>(_languageBox);
    int? languageIndex = box.get(_languageKey);
    return AppLanguages.values[languageIndex ?? AppLanguages.bn.index];
  }

  @override
  Future<void> setFavouritesItemsList(Set<String> favoritesList) async {
    final box = await Hive.openBox<List<String>>(_favoritesBox);
    await box.put(_favoritesKey, favoritesList.toList());
  }

  @override
  Future<Set<String>> getFavouritesItemsList() async {
    final box = await Hive.openBox<List<String>>(_favoritesBox);
    List<String>? favoritesList = box.get(_favoritesKey);
    return favoritesList?.toSet() ?? {};
  }

  @override
  Future<void> setSliderData(String sliderData) async {
    final box = await Hive.openBox<String>(_sliderBox);
    await box.put(_sliderDataKey, sliderData);
  }

  @override
  Future<String?> getSliderData() async {
    final box = await Hive.openBox<String>(_sliderBox);
    return box.get(_sliderDataKey);
  }

  @override
  Future<void> setCategoriesData(String categoriesData) async {
    final box = await Hive.openBox<String>(_categoriesBox);
    await box.put(_categoriesDataKey, categoriesData);
  }

  @override
  Future<String?> getCategoriesData() async {
    final box = await Hive.openBox<String>(_categoriesBox);
    return box.get(_categoriesDataKey);
  }

  @override
  Future<void> setSingleAdvertisementData(
    String singleAdvertisementData,
  ) async {
    final box = await Hive.openBox<String>(_singleAdvertisementBox);
    await box.put(_singleAdvertisementDataKey, singleAdvertisementData);
  }

  @override
  Future<String?> getSingleAdvertisementData() async {
    final box = await Hive.openBox<String>(_singleAdvertisementBox);
    return box.get(_singleAdvertisementDataKey);
  }

  @override
  Future<void> setMultipleAdvertisementData(
    String multipleAdvertisementData,
  ) async {
    final box = await Hive.openBox<String>(_multipleAdvertisementBox);
    await box.put(_multipleAdvertisementDataKey, multipleAdvertisementData);
  }

  @override
  Future<String?> getMultipleAdvertisementData() async {
    final box = await Hive.openBox<String>(_multipleAdvertisementBox);
    return box.get(_multipleAdvertisementDataKey);
  }

  @override
  Future<void> setPopularDistrictsData(String popularDistrictsData) async {
    final box = await Hive.openBox<String>(_popularDistrictsBox);
    await box.put(_popularDistrictsDataKey, popularDistrictsData);
  }

  @override
  Future<String?> getPopularDistrictsData() async {
    final box = await Hive.openBox<String>(_popularDistrictsBox);
    return box.get(_popularDistrictsDataKey);
  }

  @override
  Future<void> setTopDestinationsData(String topDestinationsData) async {
    final box = await Hive.openBox<String>(_topDestinationsBox);
    await box.put(_topDestinationsDataKey, topDestinationsData);
  }

  @override
  Future<String?> getTopDestinationsData() async {
    final box = await Hive.openBox<String>(_topDestinationsBox);
    return box.get(_topDestinationsDataKey);
  }

  @override
  Future<void> setSettingsData(String settingsData) async {
    final box = await Hive.openBox<String>(_settingsBox);
    await box.put(_settingsDataKey, settingsData);
  }

  @override
  Future<String?> getSettingsData() async {
    final box = await Hive.openBox<String>(_settingsBox);
    return box.get(_settingsDataKey);
  }

  @override
  Future<void> setDestinationsListData(String destinationsListData) async {
    final box = await Hive.openBox<String>(_destinationsListBox);
    await box.put(_destinationsListDataKey, destinationsListData);
    await box.put(_destinationsListTimeKey, DateTime.now().toIso8601String());
  }

  @override
  Future<String?> getDestinationsListData() async {
    final box = await Hive.openBox<String>(_destinationsListBox);
    return box.get(_destinationsListDataKey);
  }

  @override
  Future<DateTime?> getDestinationsListDataTime() async {
    final box = await Hive.openBox<String>(_destinationsListBox);
    final timeString = box.get(_destinationsListTimeKey);
    if (timeString == null) return null;
    return DateTime.tryParse(timeString);
  }

  @override
  Future<void> setAccommodationsListData(String destinationsListData) async {
    final box = await Hive.openBox<String>(_accommodationsListBox);
    await box.put(_accommodationsListDataKey, destinationsListData);
    await box.put(_accommodationsListTimeKey, DateTime.now().toIso8601String());
  }

  @override
  Future<String?> getAccommodationsListData() async {
    final box = await Hive.openBox<String>(_accommodationsListBox);
    return box.get(_accommodationsListDataKey);
  }

  @override
  Future<DateTime?> getAccommodationsListDataTime() async {
    final box = await Hive.openBox<String>(_accommodationsListBox);
    final timeString = box.get(_accommodationsListTimeKey);
    if (timeString == null) return null;
    return DateTime.tryParse(timeString);
  }
}
