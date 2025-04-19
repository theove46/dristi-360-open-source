import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dristi_open_source/core/base/base_consumer_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_assets.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/core/global_providers/language_settings/language_settings_provider.dart';
import 'package:dristi_open_source/core/global_providers/minimum_version_verify/minimum_version_provider.dart';
import 'package:dristi_open_source/core/global_providers/network_status/network_status_provider.dart';
import 'package:dristi_open_source/core/global_providers/package_info/package_info_provider.dart';
import 'package:dristi_open_source/core/global_widgets/asset_image_view.dart';
import 'package:dristi_open_source/core/global_widgets/network_error_alert.dart';
import 'package:dristi_open_source/core/routes/app_routes.dart';
import 'package:dristi_open_source/core/enums/app_language.dart';
import 'package:dristi_open_source/features/districts/providers/district_provider.dart';
import 'package:dristi_open_source/features/home/advertisements/widgets/advertisement_builder.dart';
import 'package:dristi_open_source/features/home/home_screen/providers/home_provider.dart';
import 'package:dristi_open_source/features/home/categories/widgets/categories_builder.dart';
import 'package:dristi_open_source/features/home/sliders/widgets/slider_builder.dart';
import 'package:dristi_open_source/features/home/popular_districts/widgets/popular_districts_builder.dart';
import 'package:dristi_open_source/features/home/top_destinations/widgets/top_destinations_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:pub_semver/pub_semver.dart';

class HomeScreen extends ConsumerStatefulWidget {
  final bool isVisible;

  const HomeScreen({super.key, required this.isVisible});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseConsumerStatefulWidget<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future(() {
      _getHomeComponents(isRefresh: false);
    });
  }

  Future<void> _getHomeComponents({required bool isRefresh}) async {
    final appInfoNotifier = ref.read(packageInfoProvider.notifier);
    await appInfoNotifier.loadPackageInfoState();
    final packageInfoState = ref.read(packageInfoProvider).data;

    final minAppVersionNotifier = ref.read(minimumVersionProvider.notifier);
    await minAppVersionNotifier.fetchMinimumVersionRequired();
    final minAppVersionState = ref.watch(minimumVersionProvider);

    if (packageInfoState != null &&
        Version.parse(packageInfoState.version) <
            Version.parse(minAppVersionState.data?.minVersion ?? '')) {
      _showUpdateRequiredDialog();
      return;
    }

    final appLanguageState =
        ref.watch(languageProvider).language.toLanguage.languageCode;
    final state = ref.watch(networkStatusProvider);

    if (state.data?.first != ConnectivityResult.none) {
      ref
          .read(sliderProvider.notifier)
          .getSliderComponents(
            appLanguage: appLanguageState,
            isRefresh: isRefresh,
          );
      ref
          .read(categoriesProvider.notifier)
          .getCategoriesComponents(
            appLanguage: appLanguageState,
            isRefresh: isRefresh,
          );
      ref
          .read(topDestinationsProvider.notifier)
          .topDestinationsComponents(
            appLanguage: appLanguageState,
            isRefresh: isRefresh,
          );
      ref
          .read(popularDistrictProvider.notifier)
          .getPopularDistrictComponents(
            appLanguage: appLanguageState,
            isRefresh: isRefresh,
          );
      ref
          .read(districtProvider.notifier)
          .getDistrictComponents(appLanguageState);
      ref
          .read(multipleAdvertisementProvider.notifier)
          .getMultipleAdvertisementComponents();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => _getHomeComponents(isRefresh: true),
        child: CustomScrollView(
          slivers: [
            _buildSliverAppBar(),
            const SliverToBoxAdapter(child: NetworkErrorAlert()),
            _buildSliverBody(),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      floating: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: _buildAppBar(),
      ),
      expandedHeight: AppValues.dimen_70.h,
      automaticallyImplyLeading: false,
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: GestureDetector(
        onTap: () {
          context.pushNamed(AppRoutes.destinationsList);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppValues.dimen_16.w),
          child: Container(
            height: AppValues.dimen_50.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: uiColors.scrim,
              borderRadius: BorderRadius.all(
                Radius.circular(AppValues.dimen_10.r),
              ),
              border: Border.all(
                color: uiColors.scrim,
                width: AppValues.dimen_1.r,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(AppValues.dimen_10.r),
              child: Row(
                children: [
                  AssetImageView(
                    fileName: Assets.search,
                    height: AppValues.dimen_24.r,
                    width: AppValues.dimen_24.r,
                    color: uiColors.primary,
                  ),
                  SizedBox(width: AppValues.dimen_10.w),
                  Text(
                    context.localization.search,
                    style: appTextStyles.blushNovaRegular12,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSliverBody() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(bottom: AppValues.dimen_16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SliderBuilder(isVisible: widget.isVisible),
            _buildTitleMessage(),
            const CategoriesBuilder(),
            AdvertisementBuilder(isVisible: widget.isVisible),
            const TopDestinationBuilder(),
            const PopularDistrictsBuilder(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleMessage() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppValues.dimen_16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.localization.exploreThe,
            style: appTextStyles.primaryNovaBold20,
          ),
          Text(
            context.localization.beautifulBD,
            style: appTextStyles.primaryNovaBold28,
          ),
          const Divider(),
        ],
      ),
    );
  }

  void _showUpdateRequiredDialog() {
    final InAppReview inAppReview = InAppReview.instance;

    Future<void> openStoreListing() => inAppReview.openStoreListing();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            title: Text(
              context.localization.updateRequired,
              style: appTextStyles.secondaryNovaSemiBold20,
            ),
            content: Text(
              context.localization.updateMessage,
              style: appTextStyles.secondaryNovaRegular16,
            ),
            actions: [
              TextButton(
                onPressed: openStoreListing,
                child: Text(
                  context.localization.updateNow,
                  style: appTextStyles.primaryNovaSemiBold16,
                ),
              ),
            ],
          ),
    );
  }
}
