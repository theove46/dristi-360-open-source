import 'package:dristi_open_source/core/base/base_consumer_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_assets.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/core/global_providers/deep_linking/deep_linking_provider.dart';
import 'package:dristi_open_source/core/global_widgets/asset_image_view.dart';
import 'package:dristi_open_source/core/global_widgets/primary_snackbar.dart';
import 'package:dristi_open_source/core/enums/app_language.dart';
import 'package:dristi_open_source/features/settings/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialMediaFollow extends ConsumerStatefulWidget {
  const SocialMediaFollow({super.key});

  @override
  ConsumerState<SocialMediaFollow> createState() => _SocialMediaFollowState();
}

class _SocialMediaFollowState
    extends BaseConsumerStatefulWidget<SocialMediaFollow> {
  @override
  Widget build(BuildContext context) {
    final settingsState = ref.watch(settingsProvider);
    final settingsStateData = settingsState.data;

    final deepLinkingNotifier = ref.read(deepLinkingProvider.notifier);

    final socialAccountsOpeningError =
        context.localization.socialAccountsOpeningError;

    if (settingsStateData == null) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        Text(
          context.localization.followDristi,
          style: appTextStyles.primaryNovaBold20,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppValues.dimen_10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialMediaButton(
              asset: Assets.youtube,
              onPressed: () async {
                try {
                  await deepLinkingNotifier.openSocialAccountsOrLinks(
                    url: settingsStateData.follow.youtubeUrl,
                  );
                } catch (error) {
                  _errorSnackBar(socialAccountsOpeningError);
                }
              },
            ),
            SizedBox(width: AppValues.dimen_16.w),
            _buildSocialMediaButton(
              asset: Assets.facebook,
              onPressed: () async {
                try {
                  await deepLinkingNotifier.openSocialAccountsOrLinks(
                    url: settingsStateData.follow.facebookUrl,
                  );
                } catch (error) {
                  _errorSnackBar(socialAccountsOpeningError);
                }
              },
            ),
            SizedBox(width: AppValues.dimen_16.w),
            _buildSocialMediaButton(
              asset: Assets.instagram,
              onPressed: () async {
                try {
                  await deepLinkingNotifier.openSocialAccountsOrLinks(
                    url: settingsStateData.follow.instagramUrl,
                  );
                } catch (error) {
                  _errorSnackBar(socialAccountsOpeningError);
                }
              },
            ),
          ],
        ),
        SizedBox(height: AppValues.dimen_30.h),
      ],
    );
  }

  Widget _buildSocialMediaButton({
    required String asset,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: AssetImageView(
        fileName: asset,
        height: AppValues.dimen_40.r,
        width: AppValues.dimen_40.r,
      ),
    );
  }

  void _errorSnackBar(String message) async {
    ShowSnackBarMessage.showErrorSnackBar(message: message, context: context);
  }
}
