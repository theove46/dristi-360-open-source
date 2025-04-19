import 'package:dristi_open_source/core/base/base_consumer_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_assets.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/core/global_providers/spots/spot_providers.dart';
import 'package:dristi_open_source/core/global_widgets/asset_image_view.dart';
import 'package:dristi_open_source/core/enums/app_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpotListScreenFilteredRow extends ConsumerStatefulWidget {
  const SpotListScreenFilteredRow({
    required this.districtController,
    this.categoryController,
    super.key,
  });

  final TextEditingController districtController;
  final TextEditingController? categoryController;

  @override
  ConsumerState<SpotListScreenFilteredRow> createState() => _FilteredRowState();
}

class _FilteredRowState
    extends BaseConsumerStatefulWidget<SpotListScreenFilteredRow> {
  @override
  Widget build(BuildContext context) {
    final categoryFieldState = ref.watch(spotsListCategoryField);
    final districtFieldState = ref.watch(spotsListDistrictField);

    final categoryFieldNotifier = ref.read(spotsListCategoryField.notifier);
    final districtFieldNotifier = ref.read(spotsListDistrictField.notifier);

    final isShowFavouriteDestinationsState = ref.watch(
      spotsListIsShowFavourite,
    );

    final isShowFavouriteDestinationsNotifier = ref.read(
      spotsListIsShowFavourite.notifier,
    );

    return SliverToBoxAdapter(
      child:
          categoryFieldNotifier.state.isNotEmpty ||
                  districtFieldNotifier.state.isNotEmpty ||
                  isShowFavouriteDestinationsState
              ? Padding(
                padding: EdgeInsets.symmetric(horizontal: AppValues.dimen_8.w),
                child: SizedBox(
                  height: AppValues.dimen_40.h,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (isShowFavouriteDestinationsState)
                          _buildFilterItem(
                            text: context.localization.favouritePlaces,
                            onTap: () {
                              isShowFavouriteDestinationsNotifier.state =
                                  !isShowFavouriteDestinationsNotifier.state;
                            },
                            isCloseIcon: true,
                          ),
                        if (districtFieldState.isNotEmpty)
                          _buildFilterItem(
                            text: districtFieldState,
                            onTap: () {
                              districtFieldNotifier.state = '';
                              widget.districtController.clear();
                            },
                            isCloseIcon: true,
                          ),
                        if (categoryFieldState.isNotEmpty)
                          _buildFilterItem(
                            text: categoryFieldState,
                            onTap: () {
                              categoryFieldNotifier.state = '';
                              widget.categoryController?.clear();
                            },
                            isCloseIcon: true,
                          ),
                      ],
                    ),
                  ),
                ),
              )
              : const SizedBox.shrink(),
    );
  }

  Widget _buildFilterItem({
    required String text,
    VoidCallback? onTap,
    required bool isCloseIcon,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppValues.dimen_8.w),
      padding: EdgeInsets.symmetric(
        horizontal: AppValues.dimen_12.r,
        vertical: AppValues.dimen_6.r,
      ),
      decoration: BoxDecoration(
        color: uiColors.scrim,
        borderRadius: BorderRadius.circular(AppValues.dimen_10.r),
        // border: Border.all(color: Colors.grey),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text, style: appTextStyles.secondaryNovaRegular12),
          SizedBox(width: AppValues.dimen_6.w),
          GestureDetector(
            onTap: onTap,
            child: AssetImageView(
              fileName: isCloseIcon ? Assets.close : Assets.heartFill,
              height: AppValues.dimen_16.r,
              width: AppValues.dimen_16.r,
              color: uiColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
