import 'package:dristi_open_source/core/global_providers/favourites_items/favourites_items_provider.dart';
import 'package:dristi_open_source/core/global_providers/spots/spot_providers.dart';
import 'package:dristi_open_source/domain/entities/destinations_list_entity.dart';
import 'package:dristi_open_source/features/destinations_list/providers/destinations_list_notifier.dart';
import 'package:dristi_open_source/features/destinations_list/providers/destinations_list_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final destinationsListProvider =
    NotifierProvider<DestinationsListNotifier, DestinationsListState>(
      DestinationsListNotifier.new,
      name: 'destinationsListProvider',
    );

final filteredDestinationsListProvider =
    StateProvider<List<DestinationsListEntity>>((ref) {
      final destinationsListItems = ref.watch(destinationsListProvider);
      final searchFieldState = ref.watch(spotsListSearchField);
      final categoryFieldState = ref.watch(spotsListCategoryField);
      final districtFieldState = ref.watch(spotsListDistrictField);
      final favoriteDestinationsState = ref.watch(favouriteItemsProvider).data;
      final isShowFavouriteDestinationsState = ref.watch(
        spotsListIsShowFavourite,
      );

      final allDestinations = destinationsListItems.data ?? [];

      return allDestinations.where((destinationData) {
        var checkTitle = destinationData.title.toLowerCase();
        var checkDistrict = destinationData.district.toLowerCase();
        var checkDivision = destinationData.division.toLowerCase();
        var checkCategory =
            destinationData.category.map((c) => c.toLowerCase()).toList();

        bool matchesSearch =
            checkTitle.contains(searchFieldState.toLowerCase()) ||
            checkDistrict.contains(searchFieldState.toLowerCase()) ||
            checkDivision.contains(searchFieldState.toLowerCase());

        bool matchesCategory =
            categoryFieldState.isEmpty ||
            checkCategory.contains(categoryFieldState.toLowerCase());

        bool matchesDistrict =
            districtFieldState.isEmpty ||
            checkDistrict.contains(districtFieldState.toLowerCase());

        bool matchesFavourites =
            !isShowFavouriteDestinationsState ||
            favoriteDestinationsState.contains(destinationData.id);

        return matchesSearch &&
            matchesCategory &&
            matchesDistrict &&
            matchesFavourites;
      }).toList();
    }, name: 'filteredDestinationsListProvider');
