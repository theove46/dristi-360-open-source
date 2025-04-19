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

class Contribution extends ConsumerStatefulWidget {
  const Contribution({super.key});

  @override
  ConsumerState<Contribution> createState() => _ContributionState();
}

class _ContributionState extends BaseConsumerStatefulWidget<Contribution> {
  @override
  Widget build(BuildContext context) {
    final settingsState = ref.watch(settingsProvider);
    final settingsStateData = settingsState.data;

    final deepLinkingNotifier = ref.read(deepLinkingProvider.notifier);

    final contributionOpeningError =
        context.localization.contributionOpeningError;

    if (settingsStateData == null) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        Text(
          context.localization.contributionMessage,
          style: appTextStyles.primaryNovaBold20,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppValues.dimen_10.h),
        GestureDetector(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.localization.googleForm,
                style: appTextStyles.primaryNovaRegular16,
              ),
              SizedBox(width: AppValues.dimen_10.w),
              _buildSocialMediaButton(
                asset: Assets.googleForm,
                onPressed: () async {
                  try {
                    await deepLinkingNotifier.openSocialAccountsOrLinks(
                      url: settingsStateData.contribution.googleForm,
                    );
                  } catch (error) {
                    _errorSnackBar(contributionOpeningError);
                  }
                },
              ),
            ],
          ),
        ),
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
