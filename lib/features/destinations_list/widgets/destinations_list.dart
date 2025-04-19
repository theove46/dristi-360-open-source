import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dristi_open_source/core/base/base_consumer_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_assets.dart';
import 'package:dristi_open_source/core/constants/app_global_texts.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/core/global_providers/favourites_items/favourites_items_provider.dart';
import 'package:dristi_open_source/core/global_providers/network_status/network_status_provider.dart';
import 'package:dristi_open_source/core/global_widgets/asset_image_view.dart';
import 'package:dristi_open_source/core/global_widgets/custom_network_image.dart';
import 'package:dristi_open_source/core/global_widgets/sliver_empty_list_image.dart';
import 'package:dristi_open_source/core/global_widgets/shimmers.dart';
import 'package:dristi_open_source/core/routes/app_router.dart';
import 'package:dristi_open_source/core/routes/app_routes.dart';
import 'package:dristi_open_source/domain/entities/destinations_list_entity.dart';
import 'package:dristi_open_source/features/destinations_list/providers/destinations_list_provider.dart';
import 'package:dristi_open_source/features/destinations_list/providers/destinations_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class DestinationsList extends ConsumerStatefulWidget {
  const DestinationsList({super.key});

  @override
  ConsumerState createState() => _DestinationsListState();
}

class _DestinationsListState
    extends BaseConsumerStatefulWidget<DestinationsList> {
  @override
  Widget build(BuildContext context) {
    final destinationsListItems = ref.watch(destinationsListProvider);

    if (destinationsListItems.status != DestinationListStatus.success ||
        destinationsListItems.data == null) {
      return buildDestinationsListShimmer(context);
    }

    final fetchResult = ref.watch(filteredDestinationsListProvider);

    if (fetchResult.isEmpty) {
      return const SliverEmptyListImage();
    }

    return SliverPadding(
      padding: EdgeInsets.only(
        left: AppValues.dimen_8.r,
        right: AppValues.dimen_8.r,
        bottom: AppValues.dimen_16.r,
      ),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: AppValues.dimen_80.r / AppValues.dimen_100.r,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          return _buildDestinationCard(fetchResult[index]);
        }, childCount: fetchResult.length),
      ),
    );
  }

  Widget _buildDestinationCard(DestinationsListEntity item) {
    return GestureDetector(
      onTap: () {
        _navigateToDestinationScreen(item.id);
      },
      child: Card(
        margin: EdgeInsets.all(AppValues.dimen_8.h),
        shadowColor: uiColors.shadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppValues.dimen_16.r),
        ),
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
    );
  }

  Widget _buildImage(DestinationsListEntity item) {
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

  Widget _buildFavouriteIcon(DestinationsListEntity item) {
    final isFavorite = ref.watch(favouriteItemsProvider).data.contains(item.id);

    return GestureDetector(
      onTap: () {
        ref
            .read(favouriteItemsProvider.notifier)
            .toggleFavouritesItems(item.id);
      },
      child: Padding(
        padding: EdgeInsets.all(AppValues.dimen_10.w),
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

  Widget _buildLabels(DestinationsListEntity item) {
    return Padding(
      padding: EdgeInsets.all(AppValues.dimen_10.w),
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
