import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dristi_open_source/core/constants/app_assets.dart';
import 'package:dristi_open_source/core/global_providers/network_status/network_status_provider.dart';
import 'package:dristi_open_source/core/global_providers/package_info/package_info_provider.dart';
import 'package:dristi_open_source/core/global_widgets/network_error_alert.dart';
import 'package:dristi_open_source/core/routes/app_routes.dart';
import 'package:dristi_open_source/core/base/base_consumer_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/core/global_providers/language_settings/language_settings_provider.dart';
import 'package:dristi_open_source/core/enums/app_language.dart';
import 'package:dristi_open_source/features/settings/providers/settings_provider.dart';
import 'package:dristi_open_source/features/settings/widgets/contact.dart';
import 'package:dristi_open_source/features/settings/widgets/contribution.dart';
import 'package:dristi_open_source/features/settings/widgets/follow_social_accounts.dart';
import 'package:dristi_open_source/features/settings/widgets/language_settings.dart';
import 'package:dristi_open_source/features/settings/widgets/ratings_and_review.dart';
import 'package:dristi_open_source/features/settings/widgets/settings_bottom_sheet.dart';
import 'package:dristi_open_source/features/settings/widgets/settings_item.dart';
import 'package:dristi_open_source/features/settings/widgets/theme_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends BaseConsumerStatefulWidget<SettingsScreen> {
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
        child: CustomScrollView(
          slivers: [
            _buildSettingsAppBar(),
            const SliverToBoxAdapter(child: NetworkErrorAlert()),
            SliverPadding(
              padding: EdgeInsets.only(
                left: AppValues.dimen_16.r,
                right: AppValues.dimen_16.r,
                bottom: AppValues.dimen_32.r,
              ),
              sliver: _buildSettingsItemsList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsAppBar() {
    return SliverAppBar(
      floating: true,
      flexibleSpace: FlexibleSpaceBar(
        background: AppBar(
          title: Text(context.localization.settings),
          centerTitle: true,
        ),
      ),
      expandedHeight: AppValues.dimen_70.h,
    );
  }

  Widget _buildSettingsItemsList() {
    final settingsItems = [
      const ThemeSettings(),
      const LanguageSettings(),
      const FollowSocialAccounts(),
      const RatingsAndReview(),
      _buildShareApp(),
      const Contribution(),
      const Contact(),
      _buildMakePromotion(),

      /// TODO: Add support us screen in next release
      // SettingsItems(
      //   icon: Assets.support,
      //   title: context.localization.support,
      //   onTap: () {},
      // ),

      /// TODO: Add privacy policy in next release
      // _buildPrivacyPolicy(),

      /// TODO: Add terms of service in next release
      // _buildTermsOfService(),
      _buildAppVersion(),
    ];

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => settingsItems[index],
        childCount: settingsItems.length,
      ),
    );
  }

  Widget _buildShareApp() {
    final settingsState = ref.watch(settingsProvider);
    final settingsStateData = settingsState.data;

    if (settingsStateData == null) {
      return const SizedBox.shrink();
    }

    return SettingsItems(
      icon: Assets.share,
      title: context.localization.shareDristi,
      onTap: () {
        Share.share(
          settingsStateData.share.shareLink,
          subject: settingsStateData.share.description,
        );
      },
    );
  }

  Widget _buildMakePromotion() {
    return SettingsItems(
      icon: Assets.promotion,
      title: context.localization.makePromotion,
      onTap: () {
        _navigateToPromotionScreen();
      },
    );
  }

  Widget _buildPrivacyPolicy() {
    final settingsState = ref.watch(settingsProvider);
    final settingsStateData = settingsState.data;

    if (settingsStateData == null) {
      return const SizedBox.shrink();
    }

    return SettingsItems(
      icon: Assets.privacy,
      title: context.localization.privacyPolicy,
      onTap: () {
        _showDetailsBottomSheet(
          title: context.localization.privacyPolicy,
          description: settingsStateData.privacyPolicy.description,
          listItems: settingsStateData.privacyPolicy.policies,
        );
      },
    );
  }

  Widget _buildTermsOfService() {
    final settingsState = ref.watch(settingsProvider);
    final settingsStateData = settingsState.data;

    if (settingsStateData == null) {
      return const SizedBox.shrink();
    }

    return SettingsItems(
      icon: Assets.terms,
      title: context.localization.termsOfService,
      onTap: () {
        _showDetailsBottomSheet(
          title: context.localization.termsOfService,
          description: settingsStateData.termsServices.description,
          listItems: settingsStateData.termsServices.terms,
        );
      },
    );
  }

  Widget _buildAppVersion() {
    final packageInfoState = ref.read(packageInfoProvider).data;

    return SettingsItems(
      icon: Assets.version,
      title: context.localization.appVersion,
      subTitle: packageInfoState?.version ?? '',
    );
  }

  void _showDetailsBottomSheet<T>({
    required String title,
    required String description,
    required List<String> listItems,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SettingsBottomSheet(
          title: title,
          description: description,
          listItems: listItems,
        );
      },
    );
  }

  void _navigateToPromotionScreen() {
    context.pushNamed(AppRoutes.promotion);
  }
}
