import 'package:dristi_open_source/core/base/base_consumer_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_assets.dart';
import 'package:dristi_open_source/core/enums/app_language.dart';
import 'package:dristi_open_source/features/settings/providers/settings_provider.dart';
import 'package:dristi_open_source/features/settings/widgets/settings_bottom_sheet.dart';
import 'package:dristi_open_source/features/settings/widgets/settings_item.dart';
import 'package:dristi_open_source/features/settings/widgets/social_accounts_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_review/in_app_review.dart';

class RatingsAndReview extends ConsumerStatefulWidget {
  const RatingsAndReview({super.key});

  @override
  ConsumerState createState() => _RatingsAndReviewState();
}

class _RatingsAndReviewState
    extends BaseConsumerStatefulWidget<RatingsAndReview> {
  final InAppReview _inAppReview = InAppReview.instance;

  Future<void> _openStoreListing() => _inAppReview.openStoreListing();

  @override
  Widget build(BuildContext context) {
    final settingsState = ref.watch(settingsProvider);
    final settingsStateData = settingsState.data;

    if (settingsStateData == null) {
      return const SizedBox.shrink();
    }

    final ratingsReviewsState = settingsStateData.ratingsReviews;

    Widget buildCallBackWidget() {
      return SocialAccountsTile(
        title: context.localization.playStore,
        url: ratingsReviewsState.playStoreLink,
        icon: Assets.playStore,
        onPressed: _openStoreListing,
      );
    }

    return SettingsItems(
      icon: Assets.ratings,
      title: context.localization.ratingsAndReview,
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return SettingsBottomSheet(
              title: context.localization.ratingsAndReview,
              description: ratingsReviewsState.description,
              callBackWidget: buildCallBackWidget(),
            );
          },
        );
      },
    );
  }
}
