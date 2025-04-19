import 'package:dristi_open_source/core/base/base_consumer_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_assets.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/core/global_widgets/asset_image_view.dart';
import 'package:dristi_open_source/core/enums/app_language.dart';
import 'package:dristi_open_source/features/travelling/widgets/travellings_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TravellingScreen extends ConsumerStatefulWidget {
  const TravellingScreen({super.key});

  @override
  ConsumerState createState() => _TravellingScreenState();
}

class _TravellingScreenState
    extends BaseConsumerStatefulWidget<TravellingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: uiColors.dark,
      body: Stack(
        children: [
          const AssetImageView(
            fileName: Assets.kaptai,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          _buildGradient(),
          Positioned(
            top: AppValues.dimen_100.r,
            left: AppValues.dimen_20.r,
            child: _buildTitleMessage(),
          ),
          Positioned(
            top: AppValues.dimen_320.h,
            child: const TravellingItems(),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipOval(
          child: Container(
            color: uiColors.light,
            child: AssetImageView(
              fileName: Assets.logo,
              height: AppValues.dimen_60.r,
              width: AppValues.dimen_60.r,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(
          context.localization.findYour,
          style: appTextStyles.onImageNovaRegular36,
        ),
        Text(
          context.localization.favouritePlace,
          style: appTextStyles.onImageNovaBold32,
        ),
      ],
    );
  }

  Widget _buildGradient() {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.topLeft,
          tileMode: TileMode.clamp,
          radius: 1.5.r,
          colors: [
            uiColors.dark,
            uiColors.dark.withValues(alpha: 0.8),
            uiColors.dark.withValues(alpha: 0.5),
            uiColors.dark.withValues(alpha: 0.2),
            uiColors.light.withValues(alpha: 0.0),
            uiColors.light.withValues(alpha: 0.0),
            uiColors.light.withValues(alpha: 0.0),
          ],
        ),
      ),
    );
  }
}
