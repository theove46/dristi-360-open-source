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

class FollowSocialAccounts extends ConsumerStatefulWidget {
  const FollowSocialAccounts({super.key});

  @override
  ConsumerState createState() => _FollowSocialAccountsState();
}

class _FollowSocialAccountsState
    extends BaseConsumerStatefulWidget<FollowSocialAccounts> {
  @override
  Widget build(BuildContext context) {
    final settingsState = ref.watch(settingsProvider);
    final settingsStateData = settingsState.data;

    final deepLinkingNotifier = ref.read(deepLinkingProvider.notifier);

    if (settingsStateData == null) {
      return const SizedBox.shrink();
    }

    final followAccountsState = settingsStateData.follow;

    final socialAccountsOpeningError =
        context.localization.socialAccountsOpeningError;

    Widget buildCallBackWidget() {
      return Column(
        children: [
          SocialAccountsTile(
            title: context.localization.facebook,
            url: followAccountsState.facebookUrl,
            icon: Assets.facebook,
            onPressed: () async {
              context.pop();
              try {
                await deepLinkingNotifier.openSocialAccountsOrLinks(
                  url: followAccountsState.facebookUrl,
                );
              } catch (error) {
                _errorSnackBar(socialAccountsOpeningError);
              }
            },
          ),
          SocialAccountsTile(
            title: context.localization.instagram,
            url: followAccountsState.instagramUrl,
            icon: Assets.instagram,
            onPressed: () async {
              context.pop();
              try {
                await deepLinkingNotifier.openSocialAccountsOrLinks(
                  url: followAccountsState.instagramUrl,
                );
              } catch (error) {
                _errorSnackBar(socialAccountsOpeningError);
              }
            },
          ),
          SocialAccountsTile(
            title: context.localization.youtube,
            url: followAccountsState.youtubeUrl,
            icon: Assets.youtube,
            onPressed: () async {
              context.pop();
              try {
                await deepLinkingNotifier.openSocialAccountsOrLinks(
                  url: followAccountsState.youtubeUrl,
                );
              } catch (error) {
                _errorSnackBar(socialAccountsOpeningError);
              }
            },
          ),
        ],
      );
    }

    return SettingsItems(
      icon: Assets.follow,
      title: context.localization.followDristi,
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return SettingsBottomSheet(
              title: context.localization.followDristi,
              description: followAccountsState.description,
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
