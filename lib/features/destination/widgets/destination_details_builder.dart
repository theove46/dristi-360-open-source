import 'package:dristi_open_source/core/base/base_consumer_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_assets.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/core/global_providers/deep_linking/deep_linking_provider.dart';
import 'package:dristi_open_source/core/global_widgets/asset_image_view.dart';
import 'package:dristi_open_source/core/global_widgets/primary_snackbar.dart';
import 'package:dristi_open_source/core/enums/app_language.dart';
import 'package:dristi_open_source/features/destination/providers/destination_data/destination_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DestinationScreenDetailsBuilder extends ConsumerStatefulWidget {
  const DestinationScreenDetailsBuilder({super.key});

  @override
  ConsumerState createState() => _DestinationScreenDetailsBuilderState();
}

class _DestinationScreenDetailsBuilderState
    extends BaseConsumerStatefulWidget<DestinationScreenDetailsBuilder> {
  @override
  Widget build(BuildContext context) {
    final destinationDataState = ref.watch(destinationProvider);
    final destinationDataStateData = destinationDataState.data;

    if (destinationDataStateData == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          destinationDataStateData.title,
          style: appTextStyles.primaryNovaBold28,
        ),
        SizedBox(height: AppValues.dimen_10.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: MediaQuery.of(context).size.width - AppValues.dimen_32.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${destinationDataStateData.district}, ${destinationDataStateData.division}",
                  style: appTextStyles.primaryNovaBold16,
                ),
                _buildFindOnMapButton(),
              ],
            ),
          ),
        ),

        SizedBox(height: AppValues.dimen_10.h),
        Text(
          destinationDataStateData.details,
          style: appTextStyles.secondaryNovaRegular16,
        ),
      ],
    );
  }

  Widget _buildFindOnMapButton() {
    final destinationDataState = ref.watch(destinationProvider);
    final googleMapsUrl = destinationDataState.data!.mapUrl;

    return GestureDetector(
      onTap: () {
        _openUrls(googleMapsUrl);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppValues.dimen_12.r,
          vertical: AppValues.dimen_12.r,
        ),
        decoration: BoxDecoration(
          color: uiColors.scrim,
          borderRadius: BorderRadius.circular(AppValues.dimen_10.r),
        ),
        child: Row(
          children: [
            Text(
              context.localization.findOnMap,
              style: appTextStyles.primaryNovaRegular12,
            ),
            SizedBox(width: AppValues.dimen_10.w),
            AssetImageView(
              fileName: Assets.location,
              height: AppValues.dimen_16.r,
              width: AppValues.dimen_16.r,
              color: uiColors.tertiary,
            ),
          ],
        ),
      ),
    );
  }

  void _openUrls(String url) async {
    final deepLinkingNotifier = ref.read(deepLinkingProvider.notifier);

    try {
      await deepLinkingNotifier.openSocialAccountsOrLinks(url: url);
    } catch (e) {
      errorSnackBar();
    }
  }

  void errorSnackBar() async {
    ShowSnackBarMessage.showErrorSnackBar(
      message: context.localization.couldNotLaunchUrl,
      context: context,
    );
  }
}
