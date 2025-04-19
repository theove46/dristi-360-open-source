import 'package:dristi_open_source/core/base/base_consumer_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_global_texts.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/domain/entities/sheet_items_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsBottomSheet extends ConsumerStatefulWidget {
  const SettingsBottomSheet({
    super.key,
    required this.title,
    this.description,
    this.listItems,
    this.items,
    this.callBackWidget,
    this.selectedItem,
    this.onItemSelected,
  });

  final String title;
  final String? description;
  final List<String>? listItems;
  final List<SheetItemEntity<dynamic>>? items;
  final Widget? callBackWidget;
  final dynamic selectedItem;
  final Function(dynamic)? onItemSelected;

  @override
  ConsumerState createState() => _SettingsBottomSheetState();
}

class _SettingsBottomSheetState
    extends BaseConsumerStatefulWidget<SettingsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppValues.dimen_16.r),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildAppbar(),
            _buildTitle(),
            const Divider(thickness: 0.5),
            if (widget.description != null) ...[_buildDescription()],
            if (widget.callBackWidget != null) ...[widget.callBackWidget!],
            if (widget.listItems != null) ...[
              for (var item in widget.listItems!) _buildTextItems(item),
            ],
            if (widget.items != null) ...[
              for (var item in widget.items!)
                _buildSelectionItems(item, context),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAppbar() {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(bottom: AppValues.dimen_40.h),
        child: Container(
          height: AppValues.dimen_6.r,
          width: AppValues.dimen_60.r,
          decoration: BoxDecoration(
            color: uiColors.scrim,
            borderRadius: BorderRadius.circular(AppValues.dimen_8.r),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.only(left: AppValues.dimen_16.w),
      child: Text(widget.title, style: appTextStyles.secondaryNovaSemiBold20),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: EdgeInsets.only(bottom: AppValues.dimen_8.h),
      child: Text(
        widget.description!,
        style: appTextStyles.secondaryNovaRegular16,
      ),
    );
  }

  Widget _buildTextItems(String item) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppValues.dimen_4.r,
        horizontal: AppValues.dimen_10.r,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TextConstants.listIndicator,
            style: appTextStyles.primaryNovaSemiBold16,
          ),
          Expanded(
            child: Text(item, style: appTextStyles.secondaryNovaRegular16),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionItems(
    SheetItemEntity<dynamic> item,
    BuildContext context,
  ) {
    return ListTile(
      title: Text(item.title, style: appTextStyles.secondaryNovaRegular16),
      trailing: Radio<dynamic>(
        value: item.value,
        groupValue: widget.selectedItem,
        onChanged: (val) {
          if (widget.onItemSelected != null) {
            widget.onItemSelected!(val);
            Navigator.pop(context);
          }
        },
        activeColor: uiColors.primary,
        fillColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return uiColors.primary;
          }
          return uiColors.primary;
        }),
      ),
    );
  }
}
