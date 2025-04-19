import 'package:dristi_open_source/core/base/base_consumer_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_assets.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/core/global_providers/deep_linking/deep_linking_provider.dart';
import 'package:dristi_open_source/domain/entities/website_entity.dart';
import 'package:dristi_open_source/core/global_widgets/asset_image_view.dart';
import 'package:dristi_open_source/core/global_widgets/primary_snackbar.dart';
import 'package:dristi_open_source/core/enums/app_language.dart';
import 'package:dristi_open_source/features/accommodation/providers/accommodation_data/accommodation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccommodationScreenDetailsBuilder extends ConsumerStatefulWidget {
  const AccommodationScreenDetailsBuilder({super.key});

  @override
  ConsumerState createState() => _AccommodationScreenDetailsBuilderState();
}

class _AccommodationScreenDetailsBuilderState
    extends BaseConsumerStatefulWidget<AccommodationScreenDetailsBuilder> {
  @override
  Widget build(BuildContext context) {
    final accommodationDataState = ref.watch(accommodationProvider);

    final accommodationDataStateData = accommodationDataState.data;

    if (accommodationDataStateData == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: AppValues.dimen_16.h),
        Text(
          accommodationDataStateData.title,
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
                  "${accommodationDataStateData.district}, ${accommodationDataStateData.division}",
                  style: appTextStyles.primaryNovaBold16,
                ),
                _buildFindOnMapButton(),
              ],
            ),
          ),
        ),
        SizedBox(height: AppValues.dimen_10.h),
        Text(
          "${context.localization.address} ${accommodationDataStateData.address}",
          style: appTextStyles.primaryNovaRegular16,
        ),
        SizedBox(height: AppValues.dimen_10.h),
        _buildWebsiteList(),
        SizedBox(height: AppValues.dimen_10.h),
        _buildPhoneNumbers(),
        SizedBox(height: AppValues.dimen_10.h),
        Text(
          accommodationDataStateData.description,
          style: appTextStyles.secondaryNovaRegular16,
        ),
        SizedBox(height: AppValues.dimen_16.h),
      ],
    );
  }

  Widget _buildFindOnMapButton() {
    final accommodationDataState = ref.watch(accommodationProvider);

    final accommodationDataStateData = accommodationDataState.data;

    if (accommodationDataStateData == null) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: () {
        _openUrls(accommodationDataStateData.mapUrl);
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

  Widget _buildWebsiteList() {
    final accommodationDataState = ref.watch(accommodationProvider);
    final accommodationDataStateData = accommodationDataState.data;
    final List<WebsiteEntity>? websites = accommodationDataStateData?.websites;

    if (accommodationDataStateData == null ||
        websites == null ||
        websites.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: AppValues.dimen_8.w,
      runSpacing: AppValues.dimen_4.h,
      children:
          websites.map((website) {
            return GestureDetector(
              onTap: () {
                _openUrls(website.url);
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
                child: Text(
                  website.site,
                  style: appTextStyles.primaryNovaRegular12,
                ),
              ),
            );
          }).toList(),
    );
  }

  Widget _buildPhoneNumbers() {
    final accommodationDataState = ref.watch(accommodationProvider);
    final accommodationDataStateData = accommodationDataState.data;
    final List<String>? phoneNumbers = accommodationDataStateData?.phones;

    if (accommodationDataStateData == null ||
        phoneNumbers == null ||
        phoneNumbers.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          phoneNumbers.map((phone) {
            return GestureDetector(
              onTap: () {
                _openUrls("tel:$phone");
              },
              child: Container(
                margin: EdgeInsets.only(bottom: AppValues.dimen_8.h),
                padding: EdgeInsets.symmetric(
                  horizontal: AppValues.dimen_12.r,
                  vertical: AppValues.dimen_12.r,
                ),
                decoration: BoxDecoration(
                  color: uiColors.scrim,
                  borderRadius: BorderRadius.circular(AppValues.dimen_10.r),
                ),
                child: Text(
                  "${context.localization.phone} $phone",
                  style: appTextStyles.primaryNovaRegular12,
                ),
              ),
            );
          }).toList(),
    );
  }

  void _openUrls(String url) async {
    final deepLinkingNotifier = ref.read(deepLinkingProvider.notifier);

    try {
      await deepLinkingNotifier.openSocialAccountsOrLinks(url: url);
    } catch (e) {
      _errorSnackBar();
    }
  }

  void _errorSnackBar() async {
    ShowSnackBarMessage.showErrorSnackBar(
      message: context.localization.couldNotLaunchUrl,
      context: context,
    );
  }
}
