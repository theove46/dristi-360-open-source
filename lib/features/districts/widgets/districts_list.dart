import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dristi_open_source/core/base/base_consumer_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_assets.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/core/global_providers/network_status/network_status_provider.dart';
import 'package:dristi_open_source/core/global_providers/spots/spot_providers.dart';
import 'package:dristi_open_source/core/global_widgets/asset_image_view.dart';
import 'package:dristi_open_source/core/global_widgets/sliver_empty_list_image.dart';
import 'package:dristi_open_source/core/global_widgets/shimmers.dart';
import 'package:dristi_open_source/core/routes/app_routes.dart';
import 'package:dristi_open_source/domain/entities/district_entity.dart';
import 'package:dristi_open_source/features/districts/providers/district_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class DistrictsList extends ConsumerStatefulWidget {
  const DistrictsList({super.key});

  @override
  ConsumerState createState() => _DistrictsListState();
}

class _DistrictsListState extends BaseConsumerStatefulWidget<DistrictsList> {
  @override
  Widget build(BuildContext context) {
    final districtModelsState = ref.watch(districtProvider);

    if (districtModelsState.data == null) {
      return buildDistrictsListShimmer(context);
    }

    final fetchResult = ref.watch(filteredDistrictsProvider);

    if (fetchResult.isEmpty) {
      return const SliverEmptyListImage();
    }

    return SliverPadding(
      padding: EdgeInsets.only(
        left: AppValues.dimen_8.r,
        right: AppValues.dimen_8.r,
        bottom: AppValues.dimen_16.r,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final int startIndex = index * 2;
          final int endIndex = startIndex + 1;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDistrictCard(fetchResult[startIndex]),
              if (endIndex < fetchResult.length)
                _buildDistrictCard(fetchResult[endIndex])
              else
                const Spacer(),
            ],
          );
        }, childCount: (fetchResult.length / 2).ceil()),
      ),
    );
  }

  Widget _buildDistrictCard(DistrictEntity item) {
    return Expanded(
      child: Card(
        margin: EdgeInsets.all(AppValues.dimen_8.h),
        shadowColor: uiColors.shadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppValues.dimen_16.r),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppValues.dimen_16.r),
            color: uiColors.background,
            border: Border.all(color: uiColors.primary),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                right: 0,
                child: Opacity(
                  opacity: 0.30,
                  child: AssetImageView(
                    fileName: Assets.forestCard,
                    fit: BoxFit.contain,
                    height: AppValues.dimen_80.r,
                    width: AppValues.dimen_80.r,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  item.title,
                  style: appTextStyles.primaryNovaSemiBold16,
                ),
                subtitle: Text(
                  item.division,
                  style: appTextStyles.secondaryNovaRegular12,
                ),
                onTap: () {
                  _navigateToDestinationsScreen(item.title);
                },
              ),
            ],
          ),
        ),
      ),
    );
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
