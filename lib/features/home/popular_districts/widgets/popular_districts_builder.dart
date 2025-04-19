import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dristi_open_source/core/base/base_consumer_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/core/global_providers/network_status/network_status_provider.dart';
import 'package:dristi_open_source/core/global_providers/spots/spot_providers.dart';
import 'package:dristi_open_source/core/global_widgets/custom_network_image.dart';
import 'package:dristi_open_source/core/routes/app_routes.dart';
import 'package:dristi_open_source/core/enums/app_language.dart';
import 'package:dristi_open_source/core/global_widgets/shimmers.dart';
import 'package:dristi_open_source/features/home/home_screen/providers/home_provider.dart';
import 'package:dristi_open_source/features/home/popular_districts/providers/popular_districts_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PopularDistrictsBuilder extends ConsumerStatefulWidget {
  const PopularDistrictsBuilder({super.key});

  @override
  ConsumerState createState() => _PopularCitiesBuilderState();
}

class _PopularCitiesBuilderState
    extends BaseConsumerStatefulWidget<PopularDistrictsBuilder> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_buildTopHeadings(), _buildDestinations()],
    );
  }

  Widget _buildTopHeadings() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppValues.dimen_16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            context.localization.popularDistricts,
            style: appTextStyles.primaryNovaBold16,
          ),
          TextButton(
            onPressed: _navigateToDistrictScreen,
            child: Text(
              context.localization.viewAll,
              style: appTextStyles.primaryNovaSemiBold12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDestinations() {
    final popularDistricts = ref.watch(popularDistrictProvider);
    final popularDistrictsData = popularDistricts.data;

    if (popularDistricts.status != PopularDistrictsStatus.success ||
        popularDistrictsData == null) {
      return buildHomeScreenPopularDistrictsShimmer(context);
    }

    return SizedBox(
      height: AppValues.dimen_160.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: popularDistrictsData.length,
        padding: EdgeInsets.symmetric(horizontal: AppValues.dimen_16.w),
        itemBuilder: (context, index) {
          final item = popularDistrictsData[index];

          return GestureDetector(
            onTap: () {
              _navigateToDestinationsScreen(item.title);
            },
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppValues.dimen_16.r),
                  child: CustomNetworkImage(
                    imageUrl: item.image,
                    width: AppValues.dimen_130.r,
                    height: AppValues.dimen_130.r,
                  ),
                ),
                SizedBox(
                  width: AppValues.dimen_120.r,
                  child: Text(
                    item.title,
                    style: appTextStyles.secondaryNovaRegular12,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder:
            (context, index) => SizedBox(width: AppValues.dimen_12.w),
      ),
    );
  }

  void _navigateToDistrictScreen() {
    context.pushNamed(AppRoutes.districts);
  }

  void _navigateToDestinationsScreen(String title) {
    ref.watch(spotsListDistrictField);
    ref.read(spotsListDistrictField.notifier).state = title;
    final networkState = ref.watch(networkStatusProvider);
    if (networkState.data?.first != ConnectivityResult.none) {
      context.pushNamed(AppRoutes.destinationsList);
    }
  }
}
