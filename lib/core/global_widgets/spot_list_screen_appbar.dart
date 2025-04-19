import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dristi_open_source/core/constants/app_assets.dart';
import 'package:dristi_open_source/core/enums/destination_filter.dart';
import 'package:dristi_open_source/core/global_widgets/asset_image_view.dart';
import 'package:dristi_open_source/core/base/base_consumer_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/core/global_providers/network_status/network_status_provider.dart';
import 'package:dristi_open_source/core/global_providers/spots/spot_providers.dart';
import 'package:dristi_open_source/core/global_widgets/filtered_bottom_sheet.dart';
import 'package:dristi_open_source/core/enums/app_language.dart';
import 'package:dristi_open_source/features/districts/providers/district_provider.dart';
import 'package:dristi_open_source/features/home/categories/providers/categories_state.dart';
import 'package:dristi_open_source/features/home/home_screen/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SpotListScreenAppBar extends ConsumerStatefulWidget {
  const SpotListScreenAppBar({
    required this.searchFieldController,
    required this.districtController,
    this.categoryController,
    super.key,
  });

  final TextEditingController searchFieldController;
  final TextEditingController districtController;
  final TextEditingController? categoryController;

  @override
  ConsumerState createState() => _SpotListScreenAppBarState();
}

class _SpotListScreenAppBarState
    extends BaseConsumerStatefulWidget<SpotListScreenAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      flexibleSpace: FlexibleSpaceBar(background: _buildAppBar()),
      automaticallyImplyLeading: false,
      expandedHeight: AppValues.dimen_70.h,
    );
  }

  Widget _buildAppBar() {
    ref.watch(spotsListSearchField);
    ref.watch(spotsListCategoryField);
    ref.watch(spotsListDistrictField);
    final searchFieldNotifier = ref.read(spotsListSearchField.notifier);
    final categoryFieldNotifier = ref.read(spotsListCategoryField.notifier);
    final districtFieldNotifier = ref.read(spotsListDistrictField.notifier);

    return AppBar(
      leading: IconButton(
        icon: AssetImageView(
          fileName: Assets.backward,
          height: AppValues.dimen_32.r,
          width: AppValues.dimen_32.r,
          color: uiColors.primary,
        ),
        onPressed: () {
          searchFieldNotifier.state = '';
          categoryFieldNotifier.state = '';
          districtFieldNotifier.state = '';
          context.pop();
        },
      ),
      title: TextField(
        controller: widget.searchFieldController,
        onChanged: (value) {
          searchFieldNotifier.state = value;
        },
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        cursorColor: uiColors.primary,
        style: appTextStyles.secondaryNovaRegular16,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: AppValues.dimen_16.r,
            horizontal: AppValues.dimen_16.r,
          ),
          hintText: context.localization.searchDestination,
          suffixIconConstraints: BoxConstraints(
            minHeight: AppValues.dimen_16.r,
            minWidth: AppValues.dimen_16.r,
          ),
          suffixIcon:
              widget.searchFieldController.text.isNotEmpty
                  ? GestureDetector(
                    onTap: () {
                      widget.searchFieldController.clear();
                      searchFieldNotifier.state = '';
                    },
                    child: Container(
                      padding: EdgeInsets.only(right: AppValues.dimen_10.w),
                      child: AssetImageView(
                        fileName: Assets.close,
                        height: AppValues.dimen_16.r,
                        width: AppValues.dimen_16.r,
                        color: uiColors.primary,
                      ),
                    ),
                  )
                  : null,
        ),
      ),
      actions: [_buildAppBarAction()],
    );
  }

  Widget _buildAppBarAction() {
    final networkState = ref.watch(networkStatusProvider);

    if (networkState.data?.first != ConnectivityResult.none) {}
    return PopupMenuButton<String>(
      icon: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppValues.dimen_10.w),
        child: AssetImageView(
          fileName: Assets.filter,
          height: AppValues.dimen_32.r,
          width: AppValues.dimen_32.r,
          color: uiColors.primary,
        ),
      ),
      itemBuilder:
          (context) =>
              networkState.data?.first != ConnectivityResult.none
                  ? [
                    if (widget.categoryController != null)
                      _buildMenuItem(
                        controller:
                            widget.categoryController ??
                            TextEditingController(),
                        hintText: context.localization.selectCategory,
                        onTap: () {
                          _showCategoryFilter();
                        },
                      ),
                    _buildMenuItem(
                      controller: widget.districtController,
                      hintText: context.localization.selectDistrict,
                      onTap: () {
                        _showDistrictFilter();
                      },
                    ),
                    _favouriteMenuItem(),
                  ]
                  : [],
    );
  }

  PopupMenuItem<String> _buildMenuItem({
    required TextEditingController controller,
    required String hintText,
    required VoidCallback onTap,
  }) {
    return PopupMenuItem(
      padding: EdgeInsets.all(AppValues.dimen_10.r),
      child: TextField(
        onTap: onTap,
        controller: controller,
        readOnly: true,
        style: appTextStyles.secondaryNovaRegular12,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: GestureDetector(
            onTap: onTap,
            child: Icon(
              Icons.arrow_drop_down_outlined,
              size: AppValues.dimen_24.r,
            ),
          ),
        ),
      ),
    );
  }

  PopupMenuItem<String> _favouriteMenuItem() {
    final isShowFavouriteDestinationState = ref.watch(spotsListIsShowFavourite);
    final isShowFavouriteDestinationNotifier = ref.read(
      spotsListIsShowFavourite.notifier,
    );

    return PopupMenuItem(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppValues.dimen_2.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.localization.favouritePlaces,
              style: appTextStyles.secondaryNovaRegular12,
            ),
            Transform.scale(
              scale: 0.75,
              child: Switch(
                value: isShowFavouriteDestinationState,
                onChanged: (value) {
                  isShowFavouriteDestinationNotifier.state = value;
                  context.pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCategoryFilter() {
    final categoryFieldNotifier = ref.read(spotsListCategoryField.notifier);
    final categoriesItems = ref.read(categoriesProvider);
    final categoriesItemsData = categoriesItems.data;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        if (categoriesItems.status != CategoriesStatus.success ||
            categoriesItemsData == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return FilteredBottomSheet(
          items: categoriesItemsData,
          notifier: categoryFieldNotifier,
          controller: widget.categoryController ?? TextEditingController(),
          text: context.localization.selectCategory,
          type: DestinationFilters.category,
        );
      },
    );
  }

  void _showDistrictFilter() {
    final districtFieldNotifier = ref.read(spotsListDistrictField.notifier);
    ref.read(districtProvider);

    final districtsItemsState = ref.watch(districtProvider);
    final districtsItemsStateData = districtsItemsState.data;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        if (districtsItemsStateData == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return FilteredBottomSheet(
          items: districtsItemsStateData,
          notifier: districtFieldNotifier,
          controller: widget.districtController,
          text: context.localization.selectDistrict,
          type: DestinationFilters.district,
        );
      },
    );
  }
}
