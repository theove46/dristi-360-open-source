import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dristi_open_source/core/base/base_consumer_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_assets.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/core/global_providers/language_settings/language_settings_provider.dart';
import 'package:dristi_open_source/core/global_providers/network_status/network_status_provider.dart';
import 'package:dristi_open_source/core/global_widgets/asset_image_view.dart';
import 'package:dristi_open_source/core/global_widgets/network_error_alert.dart';
import 'package:dristi_open_source/core/enums/app_language.dart';
import 'package:dristi_open_source/features/promotion/widgets/contact_description.dart';
import 'package:dristi_open_source/features/promotion/widgets/contribution.dart';
import 'package:dristi_open_source/features/promotion/widgets/social_media_follow.dart';
import 'package:dristi_open_source/features/settings/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PromotionScreen extends ConsumerStatefulWidget {
  const PromotionScreen({super.key});

  @override
  ConsumerState createState() => _PromotionScreenState();
}

class _PromotionScreenState
    extends BaseConsumerStatefulWidget<PromotionScreen> {
  @override
  void initState() {
    super.initState();
    Future(() {
      _getSettingsItems();
    });
  }

  Future<void> _getSettingsItems() async {
    final appLanguageState =
        ref.watch(languageProvider).language.toLanguage.languageCode;
    final networkState = ref.watch(networkStatusProvider);

    if (networkState.data?.first != ConnectivityResult.none) {
      ref
          .read(settingsProvider.notifier)
          .getSettingsComponents(
            appLanguage: appLanguageState,
            isRefresh: false,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _getSettingsItems,
        child: Stack(
          children: [
            _buildTopImage(),
            _buildDescription(),
            _buildBackNavigationIcon(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopImage() {
    return ClipRRect(
      child: AssetImageView(
        fileName: Assets.promotionScreenImage,
        fit: BoxFit.cover,
        height: AppValues.dimen_350.h,
        width: double.infinity,
      ),
    );
  }

  Widget _buildBackNavigationIcon() {
    return Positioned(
      top: AppValues.dimen_40.r,
      left: AppValues.dimen_10.r,
      child: GestureDetector(
        onTap: () => context.pop(),
        child: Container(
          height: AppValues.dimen_40.r,
          width: AppValues.dimen_40.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: uiColors.light,
          ),
          child: AssetImageView(
            fileName: Assets.backward,
            height: AppValues.dimen_20.r,
            width: AppValues.dimen_20.r,
            color: uiColors.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.6,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: uiColors.secondary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppValues.dimen_20.r),
              topRight: Radius.circular(AppValues.dimen_20.r),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: EdgeInsets.all(AppValues.dimen_16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const NetworkErrorAlert(),
                  _buildPromotionDescriptionText(),
                  const ContactDescription(),
                  const SocialMediaFollow(),
                  const Contribution(),
                  _buildThankYouImage(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPromotionDescriptionText() {
    return Center(
      child: Text(
        context.localization.promotionDescription,
        style: appTextStyles.primaryNovaRegular16,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _buildThankYouImage() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppValues.dimen_30.r),
        child: AssetImageView(
          fileName: Assets.thankYou,
          height: AppValues.dimen_100.r,
          width: AppValues.dimen_100.r,
        ),
      ),
    );
  }
}
