import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dristi_open_source/core/base/base_consumer_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_assets.dart';
import 'package:dristi_open_source/core/constants/app_global_texts.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/core/global_providers/favourites_items/favourites_items_provider.dart';
import 'package:dristi_open_source/core/global_providers/network_status/network_status_provider.dart';
import 'package:dristi_open_source/core/global_providers/spots/spot_providers.dart';
import 'package:dristi_open_source/core/global_widgets/asset_image_view.dart';
import 'package:dristi_open_source/core/global_widgets/custom_network_image.dart';
import 'package:dristi_open_source/core/global_widgets/sliver_empty_list_image.dart';
import 'package:dristi_open_source/core/global_widgets/shimmers.dart';
import 'package:dristi_open_source/core/routes/app_router.dart';
import 'package:dristi_open_source/core/routes/app_routes.dart';
import 'package:dristi_open_source/domain/entities/accommodations_list_entity.dart';
import 'package:dristi_open_source/features/accommodations_list/providers/accommodations_list_provider.dart';
import 'package:dristi_open_source/features/accommodations_list/providers/accommodations_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AccommodationsList extends ConsumerStatefulWidget {
  const AccommodationsList({super.key});

  @override
  ConsumerState createState() => _AccommodationsListState();
}

class _AccommodationsListState
    extends BaseConsumerStatefulWidget<AccommodationsList> {
  @override
  Widget build(BuildContext context) {
    final accommodationsListModelsItems = ref.watch(accommodationsListProvider);

    if (accommodationsListModelsItems.status !=
            AccommodationsListStatus.success ||
        accommodationsListModelsItems.data == null) {
      return buildAccommodationsListShimmer(context);
    }

    final fetchResult = ref.watch(filteredAccommodationsListProvider);

    if (fetchResult.isEmpty) {
      return const SliverEmptyListImage();
    }

    return SliverPadding(
      padding: EdgeInsets.only(
        left: AppValues.dimen_16.r,
        right: AppValues.dimen_16.r,
        bottom: AppValues.dimen_16.r,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return _buildAccommodationCard(fetchResult[index]);
        }, childCount: fetchResult.length),
      ),
    );
  }

  Widget _buildAccommodationCard(AccommodationsListEntity item) {
    return GestureDetector(
      onTap: () {
        _navigateToAccommodationScreen(item.id);
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: AppValues.dimen_8.r),
        child: SizedBox(
          height: AppValues.dimen_160.r,
          child: Stack(
            fit: StackFit.expand,
            children: [
              _buildImage(item),
              _buildGradient(),
              _buildFavouriteIcon(item),
              _buildLabels(item),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(AccommodationsListEntity item) {
    return Hero(
      tag: "${TextConstants.appName}-${item.id}",
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppValues.dimen_16.r),
          border: Border.all(width: 0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppValues.dimen_16.r),
          child: CustomNetworkImage(imageUrl: item.image),
        ),
      ),
    );
  }

  Widget _buildGradient() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppValues.dimen_16.r),
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          tileMode: TileMode.clamp,
          colors: [
            uiColors.dark,
            uiColors.dark.withValues(alpha: 0.25),
            uiColors.transparent,
          ],
        ),
      ),
    );
  }

  Widget _buildFavouriteIcon(AccommodationsListEntity item) {
    final isFavorite = ref.watch(favouriteItemsProvider).data.contains(item.id);

    return GestureDetector(
      onTap: () {
        ref
            .read(favouriteItemsProvider.notifier)
            .toggleFavouritesItems(item.id);
      },
      child: Padding(
        padding: EdgeInsets.all(AppValues.dimen_16.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: AppValues.dimen_24.r,
              width: AppValues.dimen_24.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: uiColors.light.withValues(alpha: 0.7),
              ),
              padding: EdgeInsets.all(AppValues.dimen_2.r),
              child: AssetImageView(
                fileName: isFavorite ? Assets.heartFill : Assets.heartOutlined,
                height: AppValues.dimen_16.r,
                width: AppValues.dimen_16.r,
                color: uiColors.error,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabels(AccommodationsListEntity item) {
    return Padding(
      padding: EdgeInsets.all(AppValues.dimen_16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.title, style: appTextStyles.onImageNovaSemiBold16),
          Text(item.district, style: appTextStyles.onImageNovaRegular12),
        ],
      ),
    );
  }

  List<AccommodationsListEntity> searchResults() {
    final accommodationsModelsItems = ref.watch(accommodationsListProvider);
    final searchFieldState = ref.watch(spotsListSearchField);
    final districtFieldState = ref.watch(spotsListDistrictField);
    final favoriteState = ref.watch(favouriteItemsProvider).data;
    final isShowFavouriteState = ref.watch(spotsListIsShowFavourite);

    List<AccommodationsListEntity> result =
        accommodationsModelsItems.data!.where((u) {
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

    return result;
  }

  void _navigateToAccommodationScreen(String id) {
    final networkState = ref.watch(networkStatusProvider);
    if (networkState.data?.first != ConnectivityResult.none) {
      final instanceId = UniqueKey().toString();
      context.pushNamed(
        AppRoutes.accommodation,
        pathParameters: {
          PathParameter.accommodationId: id,
          PathParameter.instanceId: instanceId,
        },
      );
    }
  }
}
