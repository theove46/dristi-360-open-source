import 'package:dristi_open_source/core/base/base_consumer_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/core/enums/destination_item_type.dart';
import 'package:dristi_open_source/core/global_widgets/asset_image_view.dart';
import 'package:dristi_open_source/features/destination/providers/destination_data/destination_provider.dart';
import 'package:dristi_open_source/features/destination/providers/destination_items/destination_item_provider.dart';
import 'package:dristi_open_source/features/destination/widgets/destination_blogs_builder.dart';
import 'package:dristi_open_source/features/destination/widgets/destination_cautions_builder.dart';
import 'package:dristi_open_source/features/destination/widgets/destination_details_builder.dart';
import 'package:dristi_open_source/features/destination/widgets/destination_accommodation_builder.dart';
import 'package:dristi_open_source/features/destination/widgets/destination_nearest_builder.dart';
import 'package:dristi_open_source/features/destination/widgets/destination_seasons_builder.dart';
import 'package:dristi_open_source/features/destination/widgets/destination_specials_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DestinationScreenItemsBuilder extends ConsumerStatefulWidget {
  const DestinationScreenItemsBuilder({required this.instanceId, super.key});

  final String instanceId;

  @override
  ConsumerState createState() => _DestinationScreenItemsBuilderState();
}

class _DestinationScreenItemsBuilderState
    extends BaseConsumerStatefulWidget<DestinationScreenItemsBuilder> {
  @override
  Widget build(BuildContext context) {
    final destinationItemsModelsState = ref.watch(destinationItemsProvider);

    final currentPageState = ref.watch(currentPageProvider(widget.instanceId));
    final currentPageNotifier = ref.read(
      currentPageProvider(widget.instanceId).notifier,
    );

    if (destinationItemsModelsState.data == null) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        SizedBox(
          height: AppValues.dimen_100.h,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: destinationItemsModelsState.data.length,
            itemBuilder: (context, index) {
              final item = destinationItemsModelsState.data[index];

              return GestureDetector(
                onTap: () {
                  currentPageNotifier.state = index;
                },
                child: SizedBox(
                  width: AppValues.dimen_75.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6.r),
                        child: AssetImageView(
                          fileName: item.image,
                          fit: BoxFit.cover,
                          height: AppValues.dimen_40.r,
                          width: AppValues.dimen_40.r,
                        ),
                      ),
                      SizedBox(height: AppValues.dimen_4.h),
                      Text(
                        item.title,
                        style: appTextStyles.secondaryNovaRegular12,
                      ),
                      SizedBox(height: AppValues.dimen_2.h),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          AppValues.dimen_4.r,
                        ),
                        child: Container(
                          height: AppValues.dimen_6.h,
                          width: AppValues.dimen_70.w,
                          color:
                              currentPageState == index
                                  ? uiColors.primary
                                  : uiColors.background,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        _buildPageView(
          DestinationScreenItemType.values[currentPageState],
          destinationItemsModelsState.data[currentPageState].image,
        ),
      ],
    );
  }

  Widget _buildPageView(DestinationScreenItemType screenType, String image) {
    switch (screenType) {
      case DestinationScreenItemType.detailsScreen:
        return const DestinationScreenDetailsBuilder();
      case DestinationScreenItemType.hotelsScreen:
        return const DestinationScreenAccommodationsBuilder();
      case DestinationScreenItemType.nearestScreen:
        return const DestinationScreenNearestBuilder();
      case DestinationScreenItemType.seasonsScreen:
        return const DestinationScreenSeasonsBuilder();
      case DestinationScreenItemType.specialsScreen:
        return const DestinationScreenSpecialsBuilder();
      case DestinationScreenItemType.cautionsScreen:
        return const DestinationScreenCautionsBuilder();
      case DestinationScreenItemType.blogsScreen:
        return const DestinationScreenBlogsBuilder();
    }
  }
}
