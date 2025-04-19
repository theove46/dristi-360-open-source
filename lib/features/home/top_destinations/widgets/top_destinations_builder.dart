import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dristi_open_source/core/base/base_consumer_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/core/global_providers/network_status/network_status_provider.dart';
import 'package:dristi_open_source/core/global_widgets/custom_network_image.dart';
import 'package:dristi_open_source/core/routes/app_router.dart';
import 'package:dristi_open_source/core/routes/app_routes.dart';
import 'package:dristi_open_source/core/enums/app_language.dart';
import 'package:dristi_open_source/core/global_widgets/shimmers.dart';
import 'package:dristi_open_source/features/home/home_screen/providers/home_provider.dart';
import 'package:dristi_open_source/features/home/top_destinations/providers/top_destinations_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class TopDestinationBuilder extends ConsumerStatefulWidget {
  const TopDestinationBuilder({super.key});

  @override
  ConsumerState createState() => _TopDestinationBuilderState();
}

class _TopDestinationBuilderState
    extends BaseConsumerStatefulWidget<TopDestinationBuilder> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_buildTopHeadings(), _buildDestinations()],
    );
  }

  Widget _buildTopHeadings() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppValues.dimen_16.w,
      ).copyWith(top: AppValues.dimen_16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            context.localization.topDestinations,
            style: appTextStyles.primaryNovaBold16,
          ),
          TextButton(
            onPressed: _navigateToDestinationsScreen,
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
    final topDestinationItems = ref.watch(topDestinationsProvider);
    final topDestinationItemsData = topDestinationItems.data;

    if (topDestinationItems.status != TopDestinationsStatus.success ||
        topDestinationItemsData == null) {
      return buildHomeScreenTopDestinationsShimmer(context);
    }

    return SizedBox(
      height: AppValues.dimen_110.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: topDestinationItemsData.length,
        padding: EdgeInsets.symmetric(horizontal: AppValues.dimen_16.w),
        itemBuilder: (context, index) {
          final item = topDestinationItemsData[index];
          return GestureDetector(
            onTap: () {
              _navigateToDestinationScreen(item.id);
            },
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppValues.dimen_16.r),
                  child: CustomNetworkImage(
                    imageUrl: item.image,
                    width: AppValues.dimen_80.r,
                    height: AppValues.dimen_80.r,
                  ),
                ),
                SizedBox(
                  width: AppValues.dimen_75.r,
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
            (context, index) => SizedBox(width: AppValues.dimen_8.w),
      ),
    );
  }

  void _navigateToDestinationsScreen() {
    context.pushNamed(AppRoutes.destinationsList);
  }

  void _navigateToDestinationScreen(String id) {
    final networkState = ref.watch(networkStatusProvider);
    if (networkState.data?.first != ConnectivityResult.none) {
      final instanceId = UniqueKey().toString();
      context.pushNamed(
        AppRoutes.destination,
        pathParameters: {
          PathParameter.destinationId: id,
          PathParameter.instanceId: instanceId,
        },
      );
    }
  }
}
