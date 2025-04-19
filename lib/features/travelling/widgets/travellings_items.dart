import 'package:dristi_open_source/core/base/base_consumer_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_assets.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/core/global_providers/spots/spot_providers.dart';
import 'package:dristi_open_source/core/global_widgets/asset_image_view.dart';
import 'package:dristi_open_source/core/routes/app_routes.dart';
import 'package:dristi_open_source/core/enums/app_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class TravellingItems extends ConsumerStatefulWidget {
  const TravellingItems({super.key});

  @override
  ConsumerState createState() => _TravellingItemsState();
}

class _TravellingItemsState
    extends BaseConsumerStatefulWidget<TravellingItems> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppValues.dimen_20.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildItem(
            title: context.localization.allDistrictsBD,
            icon: Assets.districts,
            onTap: () {
              _navigateToDistrictScreen();
            },
          ),
          _buildItem(
            title: context.localization.destinations,
            icon: Assets.destinations,
            onTap: () {
              _navigateToDestinationsScreen();
            },
          ),
          _buildItem(
            title: context.localization.hotelsAndResorts,
            icon: Assets.hotels,
            onTap: () {
              _navigateToAccommodationScreen();
            },
          ),
          _buildItem(
            title: context.localization.favouritePlaces,
            icon: Assets.favorites,
            onTap: () {
              _navigateToFavouritesScreen();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildItem({
    required String title,
    required String icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: AppValues.dimen_240.w,
        child: Card(
          color: uiColors.light.withValues(alpha: 0.5),
          elevation: 1,
          margin: EdgeInsets.all(AppValues.dimen_8.h),
          shadowColor: uiColors.shadow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppValues.dimen_16.r),
          ),
          child: Row(
            children: [
              Card(
                color: uiColors.light,
                child: SizedBox(
                  height: AppValues.dimen_40.r,
                  width: AppValues.dimen_40.r,
                  child: Padding(
                    padding: EdgeInsets.all(AppValues.dimen_4.r),
                    child: AssetImageView(fileName: icon, fit: BoxFit.cover),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppValues.dimen_10.w),
                child: Text(title, style: appTextStyles.darkNovaBold12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToDistrictScreen() {
    context.pushNamed(AppRoutes.districts);
  }

  void _navigateToDestinationsScreen() {
    context.pushNamed(AppRoutes.destinationsList);
  }

  void _navigateToAccommodationScreen() {
    context.pushNamed(AppRoutes.accommodationsList);
  }

  void _navigateToFavouritesScreen() {
    ref.watch(spotsListIsShowFavourite);
    final isShowFavouriteHotelsNotifier = ref.read(
      spotsListIsShowFavourite.notifier,
    );

    isShowFavouriteHotelsNotifier.state = true;

    context.pushNamed(AppRoutes.destinationsList);
  }
}
