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

class ContactDescription extends ConsumerStatefulWidget {
  const ContactDescription({super.key});

  @override
  ConsumerState<ContactDescription> createState() => _ContactDescriptionState();
}

class _ContactDescriptionState
    extends BaseConsumerStatefulWidget<ContactDescription> {
  @override
  Widget build(BuildContext context) {
    final settingsState = ref.watch(settingsProvider);
    final settingsStateData = settingsState.data;

    final deepLinkingNotifier = ref.read(deepLinkingProvider.notifier);

    final emailErrorMessage = context.localization.emailAppOpeningError;
    final whatsAppErrorMessage = context.localization.whatsAppOpeningError;

    if (settingsStateData == null) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        SizedBox(height: AppValues.dimen_30.h),
        Text(
          context.localization.contactUs,
          style: appTextStyles.primaryNovaBold20,
          textAlign: TextAlign.center,
        ),
        _buildContactButton(
          asset: Assets.email,
          title: settingsStateData.contact.email,
          onPressed: () async {
            try {
              await deepLinkingNotifier.navigateToEmail(
                emailAccount: settingsStateData.contact.email,
              );
            } catch (error) {
              _errorSnackBar(emailErrorMessage);
            }
          },
        ),
        SizedBox(height: AppValues.dimen_20.h),
        _buildContactButton(
          asset: Assets.whatsapp,
          title: settingsStateData.contact.whatsapp,
          onPressed: () async {
            try {
              await deepLinkingNotifier.navigateToWhatsappMessage(
                phoneNumber: settingsStateData.contact.whatsapp,
              );
            } catch (error) {
              _errorSnackBar(whatsAppErrorMessage);
            }
          },
        ),
        SizedBox(height: AppValues.dimen_30.h),
      ],
    );
  }

  Widget _buildContactButton({
    required String asset,
    required String title,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        children: [
          AssetImageView(
            fileName: asset,
            height: AppValues.dimen_40.r,
            width: AppValues.dimen_40.r,
          ),
          SizedBox(width: AppValues.dimen_20.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: appTextStyles.primaryNovaRegular16),
              Text(
                context.localization.clickHereToContinue,
                style: appTextStyles.primaryNovaRegular12,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _errorSnackBar(String message) async {
    ShowSnackBarMessage.showErrorSnackBar(message: message, context: context);
  }
}
