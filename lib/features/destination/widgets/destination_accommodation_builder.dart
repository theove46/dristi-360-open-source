import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dristi_open_source/core/base/base_consumer_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/core/global_providers/language_settings/language_settings_provider.dart';
import 'package:dristi_open_source/core/global_providers/network_status/network_status_provider.dart';
import 'package:dristi_open_source/core/global_widgets/custom_network_image.dart';
import 'package:dristi_open_source/core/global_widgets/empty_list_image.dart';
import 'package:dristi_open_source/core/routes/app_router.dart';
import 'package:dristi_open_source/core/routes/app_routes.dart';
import 'package:dristi_open_source/core/enums/app_language.dart';
import 'package:dristi_open_source/features/accommodations_list/providers/accommodations_list_provider.dart';
import 'package:dristi_open_source/features/destination/providers/destination_data/destination_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class DestinationScreenAccommodationsBuilder extends ConsumerStatefulWidget {
  const DestinationScreenAccommodationsBuilder({super.key});

  @override
  ConsumerState createState() => _DestinationScreenAccommodationsBuilderState();
}

class _DestinationScreenAccommodationsBuilderState
    extends BaseConsumerStatefulWidget<DestinationScreenAccommodationsBuilder> {
  @override
  void initState() {
    super.initState();
    Future(() {
      _getAccommodationComponents();
    });
  }

  Future<void> _getAccommodationComponents() async {
    final appLanguageState =
        ref.watch(languageProvider).language.toLanguage.languageCode;

    ref
        .read(accommodationsListProvider.notifier)
        .getAccommodationsListComponents(
          appLanguage: appLanguageState,
          isRefresh: false,
        );
  }

  @override
  Widget build(BuildContext context) {
    final accommodationsModelsItems = ref.watch(accommodationsListProvider);
    final destinationDataState = ref.watch(destinationProvider);

    if (accommodationsModelsItems.data == null ||
        destinationDataState.data == null) {
      return const SizedBox.shrink();
    }

    final nearestDestinations =
        accommodationsModelsItems.data!
            .where(
              (dest) => dest.district == destinationDataState.data!.district,
            )
            .toList();

    if (nearestDestinations.isEmpty) {
      return const EmptyListImage();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: nearestDestinations.length,
          itemBuilder: (context, index) {
            final nearestDestination = nearestDestinations[index];
            return GestureDetector(
              onTap: () {
                _navigateToAccommodationScreen(nearestDestination.id);
              },
              child: Card(
                color: uiColors.scrim,
                elevation: 1,
                child: Padding(
                  padding: EdgeInsets.all(AppValues.dimen_10.r),
                  child: Row(
                    children: [
                      SizedBox(width: AppValues.dimen_10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              nearestDestination.title,
                              style: appTextStyles.secondaryNovaRegular16,
                            ),
                            SizedBox(height: AppValues.dimen_10.w),
                            Text(
                              nearestDestination.district,
                              style: appTextStyles.secondaryNovaRegular12,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: AppValues.dimen_10.w),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          AppValues.dimen_10.r,
                        ),
                        child: CustomNetworkImage(
                          imageUrl: nearestDestination.image,
                          width: AppValues.dimen_60.r,
                          height: AppValues.dimen_60.r,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void _navigateToAccommodationScreen(String id) {
    final networkState = ref.watch(networkStatusProvider);
    final instanceId = UniqueKey().toString();
    if (networkState.data?.first != ConnectivityResult.none) {
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
