import 'package:dristi_open_source/core/base/base_consumer_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/core/global_widgets/asset_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsItems extends ConsumerStatefulWidget {
  const SettingsItems({
    required this.icon,
    required this.title,
    this.subTitle,
    this.onTap,
    super.key,
  });

  final String icon;
  final String title;
  final String? subTitle;
  final VoidCallback? onTap;

  @override
  ConsumerState createState() => _SettingsItemState();
}

class _SettingsItemState extends BaseConsumerStatefulWidget<SettingsItems> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: uiColors.scrim,
      elevation: 0,
      margin: EdgeInsets.symmetric(vertical: AppValues.dimen_3.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppValues.dimen_16.r),
      ),
      child: ListTile(
        leading: AssetImageView(
          fileName: widget.icon,
          height: AppValues.dimen_28.r,
          width: AppValues.dimen_28.r,
          color: uiColors.primary,
        ),
        title: Text(widget.title),
        titleTextStyle: appTextStyles.secondaryNovaRegular16,
        subtitle: widget.subTitle != null ? Text(widget.subTitle!) : null,
        subtitleTextStyle: appTextStyles.secondaryNovaRegular12,
        onTap: widget.onTap,
        minTileHeight: AppValues.dimen_60.h,
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppValues.dimen_16.r,
          vertical: AppValues.dimen_8.r,
        ),
      ),
    );
  }
}
