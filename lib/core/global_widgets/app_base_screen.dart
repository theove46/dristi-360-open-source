import 'package:dristi_open_source/core/base/base_consumer_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_assets.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/core/global_providers/bottom_nav_bar/bottom_nav_bar_providers.dart';
import 'package:dristi_open_source/core/global_providers/minimum_version_verify/minimum_version_provider.dart';
import 'package:dristi_open_source/core/global_providers/package_info/package_info_provider.dart';
import 'package:dristi_open_source/core/global_widgets/asset_image_view.dart';
import 'package:dristi_open_source/core/enums/bottom_nav_item.dart';
import 'package:dristi_open_source/features/home/home_screen/screens/home_screen.dart';
import 'package:dristi_open_source/features/settings/screens/settings_screen.dart';
import 'package:dristi_open_source/features/travelling/screens/travelling_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pub_semver/pub_semver.dart';

class AppBaseScreen extends ConsumerStatefulWidget {
  const AppBaseScreen({super.key});

  @override
  ConsumerState createState() => _AppBaseScreenState();
}

class _AppBaseScreenState extends BaseConsumerStatefulWidget<AppBaseScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavBarState = ref.watch(bottomNavBarProvider);

    return Scaffold(
      body: IndexedStack(
        index: bottomNavBarState.index,
        children: BottomNavItems.values.map(_buildTabWidget).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          _buildBottomNavigationBarItem(Assets.home, BottomNavItems.home),
          _buildBottomNavigationBarItem(
            Assets.travelling,
            BottomNavItems.travelling,
          ),
          _buildBottomNavigationBarItem(
            Assets.settings,
            BottomNavItems.settings,
          ),
        ],
        backgroundColor: uiColors.background,
        currentIndex: bottomNavBarState.index,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) => _onItemTapped(BottomNavItems.values[index]),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
    String icon,
    BottomNavItems item,
  ) {
    final bottomNavBarState = ref.watch(bottomNavBarProvider);

    return BottomNavigationBarItem(
      icon: AssetImageView(
        fileName: icon,
        fit: BoxFit.cover,
        height: AppValues.dimen_28.r,
        width: AppValues.dimen_28.r,
        color: bottomNavBarState == item ? uiColors.primary : uiColors.tertiary,
      ),
      label: bottomNavBarState.name,
    );
  }

  Widget _buildTabWidget(BottomNavItems item) {
    final isVisible = ref.watch(bottomNavBarProvider) == item;
    switch (item) {
      case BottomNavItems.home:
        return HomeScreen(isVisible: isVisible);
      case BottomNavItems.travelling:
        return const TravellingScreen();
      case BottomNavItems.settings:
        return const SettingsScreen();
    }
  }

  void _onItemTapped(BottomNavItems item) {
    final packageInfoState = ref.read(packageInfoProvider).data;
    final minAppVersionState = ref.read(minimumVersionProvider);

    if (packageInfoState != null &&
        Version.parse(packageInfoState.version) <
            Version.parse(minAppVersionState.data?.minVersion ?? '')) {
      return;
    }

    final bottomNavBarNotifier = ref.read(bottomNavBarProvider.notifier);
    bottomNavBarNotifier.state = item;
    _animationController.forward(from: 0);
  }
}
