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

class Contribution extends ConsumerStatefulWidget {
  const Contribution({super.key});

  @override
  ConsumerState createState() => _ContributionState();
}

class _ContributionState extends BaseConsumerStatefulWidget<Contribution> {
  @override
  Widget build(BuildContext context) {
    final settingsState = ref.watch(settingsProvider);
    final settingsStateData = settingsState.data;

    final deepLinkingNotifier = ref.read(deepLinkingProvider.notifier);

    if (settingsStateData == null) {
      return const SizedBox.shrink();
    }

    final contributionState = settingsStateData.contribution;

    final contributionOpeningError =
        context.localization.contributionOpeningError;

    Widget buildCallBackWidget() {
      return SocialAccountsTile(
        title: context.localization.googleForm,
        url: contributionState.googleForm,
        icon: Assets.googleForm,
        onPressed: () async {
          try {
            await deepLinkingNotifier.openSocialAccountsOrLinks(
              url: settingsStateData.contribution.googleForm,
            );
          } catch (error) {
            _errorSnackBar(contributionOpeningError);
          }
        },
      );
    }

    return SettingsItems(
      icon: Assets.contribution,
      title: context.localization.contribution,
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return SettingsBottomSheet(
              title: context.localization.contribution,
              description: contributionState.description,
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
