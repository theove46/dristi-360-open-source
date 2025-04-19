import 'package:dristi_open_source/core/base/base_consumer_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_assets.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/core/global_widgets/asset_image_view.dart';
import 'package:dristi_open_source/core/enums/app_language.dart';
import 'package:dristi_open_source/features/districts/providers/district_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class DistrictsAppBar extends ConsumerStatefulWidget {
  const DistrictsAppBar({super.key});

  @override
  ConsumerState createState() => _DistrictsAppBarState();
}

class _DistrictsAppBarState
    extends BaseConsumerStatefulWidget<DistrictsAppBar> {
  final TextEditingController _searchFieldController = TextEditingController();

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
    ref.watch(districtsSearchField);
    final searchFieldNotifier = ref.read(districtsSearchField.notifier);

    return AppBar(
      leading: IconButton(
        icon: AssetImageView(
          fileName: Assets.backward,
          height: AppValues.dimen_32.r,
          width: AppValues.dimen_32.r,
          color: uiColors.primary,
        ),
        onPressed: () {
          _searchFieldController.clear();
          searchFieldNotifier.state = '';
          context.pop();
        },
      ),
      title: Padding(
        padding: EdgeInsets.only(right: AppValues.dimen_24.r),
        child: TextField(
          controller: _searchFieldController,
          onChanged: (value) {
            searchFieldNotifier.state = value;
          },
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          cursorColor: uiColors.primary,
          style: appTextStyles.secondaryNovaRegular16,
          decoration: InputDecoration(
            hintText: context.localization.searchDistricts,
            suffixIconConstraints: BoxConstraints(
              minHeight: AppValues.dimen_16.r,
              minWidth: AppValues.dimen_16.r,
            ),
            suffixIcon:
                _searchFieldController.text.isNotEmpty
                    ? GestureDetector(
                      onTap: () {
                        _searchFieldController.clear();
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
      ),
    );
  }
}
