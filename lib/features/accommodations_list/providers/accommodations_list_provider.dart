import 'package:dristi_open_source/core/global_providers/favourites_items/favourites_items_provider.dart';
import 'package:dristi_open_source/core/global_providers/spots/spot_providers.dart';
import 'package:dristi_open_source/domain/entities/accommodations_list_entity.dart';
import 'package:dristi_open_source/features/accommodations_list/providers/accommodations_list_notifier.dart';
import 'package:dristi_open_source/features/accommodations_list/providers/accommodations_list_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accommodationsListProvider =
    NotifierProvider<AccommodationsListNotifier, AccommodationsListState>(
      AccommodationsListNotifier.new,
      name: 'accommodationsListProvider',
    );

final filteredAccommodationsListProvider =
    StateProvider<List<AccommodationsListEntity>>((ref) {
      final accommodationsModelsItems = ref.watch(accommodationsListProvider);
      final searchFieldState = ref.watch(spotsListSearchField);
      final districtFieldState = ref.watch(spotsListDistrictField);
      final favoriteState = ref.watch(favouriteItemsProvider).data;
      final isShowFavouriteState = ref.watch(spotsListIsShowFavourite);

      final allAccommodations = accommodationsModelsItems.data ?? [];

      return allAccommodations.where((u) {
        var checkTitle = u.title.toLowerCase();
        var checkDistrict = u.district.toLowerCase();
        var checkDivision = u.division.toLowerCase();

        bool matchesSearch =
            checkTitle.contains(searchFieldState.toLowerCase()) ||
            checkDistrict.contains(searchFieldState.toLowerCase()) ||
            checkDivision.contains(searchFieldState.toLowerCase());

        bool matchesDistrict =
            districtFieldState.isEmpty ||
            checkDistrict.contains(districtFieldState.toLowerCase());

        bool matchesFavourites =
            !isShowFavouriteState || favoriteState.contains(u.id);

        return matchesSearch && matchesDistrict && matchesFavourites;
      }).toList();
    }, name: 'filteredAccommodationsListProvider');
