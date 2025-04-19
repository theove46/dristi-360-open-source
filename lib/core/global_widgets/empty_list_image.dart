import 'package:dristi_open_source/core/base/base_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_assets.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/core/global_widgets/asset_image_view.dart';
import 'package:dristi_open_source/core/enums/app_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyListImage extends StatefulWidget {
  const EmptyListImage({super.key});

  @override
  State<EmptyListImage> createState() => _EmptyListImageState();
}

class _EmptyListImageState extends BaseStatefulWidget<EmptyListImage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: AppValues.dimen_20.r),
        Text(
          context.localization.noResults,
          style: appTextStyles.primaryNovaSemiBold16,
        ),
        SizedBox(height: AppValues.dimen_10.r),
        AssetImageView(
          fileName: Assets.emptyList,
          fit: BoxFit.contain,
          height: AppValues.dimen_100.r,
          width: AppValues.dimen_100.r,
        ),
        SizedBox(height: AppValues.dimen_10.r),
        Text(
          context.localization.plantTrees,
          style: appTextStyles.primaryNovaSemiBold16,
        ),
      ],
    );
  }
}
