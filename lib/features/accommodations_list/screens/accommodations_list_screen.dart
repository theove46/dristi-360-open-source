import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dristi_open_source/core/base/base_consumer_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/core/global_providers/favourites_items/favourites_items_provider.dart';
import 'package:dristi_open_source/core/global_providers/language_settings/language_settings_provider.dart';
import 'package:dristi_open_source/core/global_providers/network_status/network_status_provider.dart';
import 'package:dristi_open_source/core/global_providers/spots/spot_providers.dart';
import 'package:dristi_open_source/core/global_widgets/advertisement_image.dart';
import 'package:dristi_open_source/core/global_widgets/network_error_alert.dart';
import 'package:dristi_open_source/core/global_widgets/spot_list_screen_appbar.dart';
import 'package:dristi_open_source/core/global_widgets/spot_list_screen_filtered_row.dart';
import 'package:dristi_open_source/core/enums/app_language.dart';
import 'package:dristi_open_source/features/accommodations_list/providers/accommodations_list_provider.dart';
import 'package:dristi_open_source/features/accommodations_list/widgets/accommodations_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccommodationsListScreen extends ConsumerStatefulWidget {
  const AccommodationsListScreen({super.key});

  @override
  ConsumerState createState() => _AccommodationsListScreenState();
}

class _AccommodationsListScreenState
    extends BaseConsumerStatefulWidget<AccommodationsListScreen> {
  @override
  void initState() {
    super.initState();
    Future(() {
      _getHotelsListComponents(isRefresh: false);
      ref.read(favouriteItemsProvider.notifier).loadSavedItems();
    });
  }

  Future<void> _getHotelsListComponents({required bool isRefresh}) async {
    final appLanguageState =
        ref.watch(languageProvider).language.toLanguage.languageCode;
    final networkState = ref.watch(networkStatusProvider);

    if (networkState.data?.first != ConnectivityResult.none) {
      ref
          .read(accommodationsListProvider.notifier)
          .getAccommodationsListComponents(
            appLanguage: appLanguageState,
            isRefresh: isRefresh,
          );
    }

    final accommodationsListState = ref.watch(spotsListDistrictField);
    if (accommodationsListState.isNotEmpty) {
      districtController.text = accommodationsListState;
    }
  }

  final TextEditingController searchFieldController = TextEditingController();
  final TextEditingController districtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: RefreshIndicator(
          onRefresh: () => _getHotelsListComponents(isRefresh: true),
          child: CustomScrollView(
            slivers: [
              SpotListScreenAppBar(
                searchFieldController: searchFieldController,
                districtController: districtController,
              ),
              const SliverToBoxAdapter(child: NetworkErrorAlert()),
              SpotListScreenFilteredRow(districtController: districtController),
              // _buildAdvertisement(), // For Future Usage
              const AccommodationsList(),
            ],
          ),
        ),
      ),
    );
  }

  // For Future Usage
  // ignore: unused_element
  Widget _buildAdvertisement() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(
          left: AppValues.dimen_16.r,
          right: AppValues.dimen_16.r,
          bottom: AppValues.dimen_10.r,
        ),
        child: const AdvertisementImage(),
      ),
    );
  }
}
