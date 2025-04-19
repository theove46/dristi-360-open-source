import 'package:dristi_open_source/features/home/advertisements/providers/advertisement_notifier.dart';
import 'package:dristi_open_source/features/home/advertisements/providers/advertisement_state.dart';
import 'package:dristi_open_source/features/home/categories/providers/categories_notifier.dart';
import 'package:dristi_open_source/features/home/categories/providers/categories_state.dart';
import 'package:dristi_open_source/features/home/popular_districts/providers/popular_districts_notifier.dart';
import 'package:dristi_open_source/features/home/popular_districts/providers/popular_districts_state.dart';
import 'package:dristi_open_source/features/home/sliders/providers/slider_notifier.dart';
import 'package:dristi_open_source/features/home/sliders/providers/slider_state.dart';
import 'package:dristi_open_source/features/home/top_destinations/providers/top_destinations_notifier.dart';
import 'package:dristi_open_source/features/home/top_destinations/providers/top_destinations_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoriesProvider =
    NotifierProvider<CategoriesNotifier, CategoriesState>(
      CategoriesNotifier.new,
      name: 'categoriesProvider',
    );

final popularDistrictProvider =
    NotifierProvider<PopularDistrictNotifier, PopularDistrictState>(
      PopularDistrictNotifier.new,
      name: 'popularDistrictProvider',
    );

final sliderProvider = NotifierProvider<SliderNotifier, SliderState>(
  SliderNotifier.new,
  name: 'sliderProvider',
);

final singleAdvertisementProvider =
    NotifierProvider<AdvertisementNotifier, AdvertisementState>(
      AdvertisementNotifier.new,
      name: 'singleAdvertisementProvider',
    );

final multipleAdvertisementProvider =
    NotifierProvider<AdvertisementNotifier, AdvertisementState>(
      AdvertisementNotifier.new,
      name: 'multipleAdvertisementProvider',
    );

final topDestinationsProvider =
    NotifierProvider<TopDestinationsNotifier, TopDestinationsState>(
      TopDestinationsNotifier.new,
      name: 'topDestinationsProvider',
    );

final currentSlideProvider = StateProvider<int>(
  (ref) => 0,
  name: 'currentSlideProvider',
);

final currentAdvertisementProvider = StateProvider<int>(
  (ref) => 0,
  name: 'currentAdvertisementProvider',
);

final categoriesExpanded = StateProvider<bool>(
  (ref) => false,
  name: 'categoriesExpanded',
);
