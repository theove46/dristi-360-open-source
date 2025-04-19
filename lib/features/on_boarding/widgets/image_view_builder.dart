import 'package:dristi_open_source/core/base/base_consumer_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_assets.dart';
import 'package:dristi_open_source/core/constants/app_global_texts.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/core/global_widgets/asset_image_view.dart';
import 'package:dristi_open_source/features/on_boarding/providers/on_boarding_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageViewBuilder extends ConsumerStatefulWidget {
  final bool hasDristiText;

  const ImageViewBuilder({super.key, required this.hasDristiText});

  @override
  ConsumerState createState() => _ImageViewBuilderState();
}

class _ImageViewBuilderState
    extends BaseConsumerStatefulWidget<ImageViewBuilder> {
  @override
  Widget build(BuildContext context) {
    final inFirstTimeState = ref.watch(inFirstTime);

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        if (inFirstTimeState)
          const ClipRRect(
            child: AssetImageView(
              fileName: Assets.coxsBazar,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
        if (widget.hasDristiText)
          Positioned(
            bottom: AppValues.dimen_160.h,
            child: Transform.rotate(
              angle: -15 * (3.1415926535 / 180),
              child: Text(
                TextConstants.appName,
                style: appTextStyles.onImageBoldShadow60,
              ),
            ),
          ),

        _buildGradient(),
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
