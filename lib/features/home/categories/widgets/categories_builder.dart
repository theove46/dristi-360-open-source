import 'package:dristi_open_source/core/base/base_consumer_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_assets.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/core/global_providers/spots/spot_providers.dart';
import 'package:dristi_open_source/core/global_widgets/asset_image_view.dart';
import 'package:dristi_open_source/core/global_widgets/custom_network_image.dart';
import 'package:dristi_open_source/core/routes/app_routes.dart';
import 'package:dristi_open_source/core/enums/app_language.dart';
import 'package:dristi_open_source/core/global_widgets/shimmers.dart';
import 'package:dristi_open_source/features/home/categories/providers/categories_state.dart';
import 'package:dristi_open_source/features/home/home_screen/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CategoriesBuilder extends ConsumerStatefulWidget {
  const CategoriesBuilder({super.key});

  @override
  ConsumerState createState() => _CategoriesBuilderState();
}

class _CategoriesBuilderState
    extends BaseConsumerStatefulWidget<CategoriesBuilder> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_buildTopHeadings(), _buildCategories()],
    );
  }

  Widget _buildTopHeadings() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppValues.dimen_10.h,
        horizontal: AppValues.dimen_16.w,
      ),
      child: Text(
        context.localization.categories,
        style: appTextStyles.primaryNovaBold16,
      ),
    );
  }

  Widget _buildCategories() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppValues.dimen_16.w),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [_buildCategoriesList(), _buildExpandedButton()],
      ),
    );
  }

  Widget _buildCategoriesList() {
    final expandState = ref.watch(categoriesExpanded);
    final categoriesItems = ref.watch(categoriesProvider);
    final categoriesItemsData = categoriesItems.data;

    if (categoriesItems.status != CategoriesStatus.success ||
        categoriesItemsData == null) {
      return buildHomeScreenCategoriesShimmer(context);
    }

    final itemCount = categoriesItemsData.length;
    final visibleCount = expandState ? itemCount : 8;
    final rowCount = (visibleCount / 4).ceil();
    final height = rowCount * AppValues.dimen_120.h;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      height: height,
      margin: EdgeInsets.all(AppValues.dimen_2.r),
      padding: EdgeInsets.all(AppValues.dimen_16.r),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.all(Radius.circular(AppValues.dimen_10.r)),
        border: Border.all(
          color: uiColors.primary.withValues(alpha: 0.5),
          width: AppValues.dimen_2.r,
        ),
      ),
      child: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Wrap(
            runSpacing: 8.r,
            spacing: 8.r,
            children: [
              ...categoriesItemsData.take(8).map((item) {
                final index = categoriesItemsData.indexOf(item);
                return _buildItems(index);
              }),
              if (expandState)
                ...categoriesItemsData.skip(8).map((item) {
                  final index = categoriesItemsData.indexOf(item);
                  return _buildItems(index);
                }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItems(int index) {
    final categoriesItems = ref.watch(categoriesProvider);
    final categoriesItemsData = categoriesItems.data;

    if (categoriesItemsData == null) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: () {
        _navigateToDestinationsScreen(categoriesItemsData[index].title);
      },
      child: SizedBox(
        width: AppValues.dimen_80.r,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: AppValues.dimen_10.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppValues.dimen_6.r),
                child: CustomNetworkImage(
                  imageUrl: categoriesItemsData[index].image,
                  width: AppValues.dimen_60.r,
                  height: AppValues.dimen_60.r,
                ),
              ),
              SizedBox(height: AppValues.dimen_4.h),
              Text(
                categoriesItemsData[index].title,
                style: appTextStyles.secondaryNovaSemiBold10,
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedButton() {
    final expandState = ref.watch(categoriesExpanded);

    return Positioned(
      bottom: -AppValues.dimen_8.h,
      child: GestureDetector(
        onTap: _onTapExpandedButton,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: AppValues.dimen_40.r,
              height: AppValues.dimen_40.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: uiColors.secondary),
                color: uiColors.secondary,
              ),
            ),
            AssetImageView(
              fileName: expandState ? Assets.up : Assets.down,
              height: AppValues.dimen_32.r,
              width: AppValues.dimen_32.r,
              color: uiColors.primary,
            ),
          ],
        ),
      ),
    );
  }

  void _onTapExpandedButton() {
    final expandNotifier = ref.read(categoriesExpanded.notifier);
    expandNotifier.state = !expandNotifier.state;
  }

  void _navigateToDestinationsScreen(String title) {
    ref.watch(spotsListCategoryField);
    if (title != context.localization.allCategories) {
      ref.read(spotsListCategoryField.notifier).state = title;
    }
    context.pushNamed(AppRoutes.destinationsList);
  }
}
