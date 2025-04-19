import 'package:dristi_open_source/core/base/base_consumer_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_assets.dart';
import 'package:dristi_open_source/core/global_providers/deep_linking/deep_linking_provider.dart';
import 'package:dristi_open_source/core/global_widgets/primary_snackbar.dart';
import 'package:dristi_open_source/core/enums/app_language.dart';
import 'package:dristi_open_source/features/settings/providers/settings_provider.dart';
import 'package:dristi_open_source/features/settings/widgets/settings_bottom_sheet.dart';
import 'package:dristi_open_source/features/settings/widgets/settings_item.dart';
import 'package:dristi_open_source/features/settings/widgets/social_accounts_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Contact extends ConsumerStatefulWidget {
  const Contact({super.key});

  @override
  ConsumerState createState() => _ContactState();
}

class _ContactState extends BaseConsumerStatefulWidget<Contact> {
  @override
  Widget build(BuildContext context) {
    final settingsState = ref.watch(settingsProvider);
    final settingsStateData = settingsState.data;

    final deepLinkingNotifier = ref.read(deepLinkingProvider.notifier);

    if (settingsStateData == null) {
      return const SizedBox.shrink();
    }

    final contactState = settingsStateData.contact;

    final emailErrorMessage = context.localization.emailAppOpeningError;
    final whatsAppErrorMessage = context.localization.whatsAppOpeningError;

    Widget buildCallBackWidget() {
      return Column(
        children: [
          SocialAccountsTile(
            title: context.localization.email,
            url: contactState.email,
            icon: Assets.email,
            onPressed: () async {
              context.pop();
              try {
                await deepLinkingNotifier.navigateToEmail(
                  emailAccount: settingsStateData.contact.email,
                );
              } catch (error) {
                _errorSnackBar(emailErrorMessage);
              }
            },
          ),
          SocialAccountsTile(
            title: context.localization.whatsapp,
            url: contactState.whatsapp,
            icon: Assets.whatsapp,
            onPressed: () async {
              context.pop();
              try {
                await deepLinkingNotifier.navigateToWhatsappMessage(
                  phoneNumber: settingsStateData.contact.whatsapp,
                );
              } catch (error) {
                _errorSnackBar(whatsAppErrorMessage);
              }
            },
          ),
        ],
      );
    }

    return SettingsItems(
      icon: Assets.contact,
      title: context.localization.contactUs,
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return SettingsBottomSheet(
              title: context.localization.contactUs,
              description: contactState.description,
              callBackWidget: buildCallBackWidget(),
            );
          },
        );
      },
    );
  }

  void _errorSnackBar(String message) async {
    ShowSnackBarMessage.showErrorSnackBar(message: message, context: context);
  }
}
