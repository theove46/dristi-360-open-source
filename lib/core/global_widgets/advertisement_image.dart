import 'package:dristi_open_source/core/base/base_consumer_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/core/enums/app_language.dart';
import 'package:dristi_open_source/core/global_widgets/custom_network_image.dart';
import 'package:dristi_open_source/core/global_widgets/shimmers.dart';
import 'package:dristi_open_source/core/routes/app_routes.dart';
import 'package:dristi_open_source/features/home/advertisements/providers/advertisement_state.dart';
import 'package:dristi_open_source/features/home/home_screen/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AdvertisementImage extends ConsumerStatefulWidget {
  const AdvertisementImage({super.key});

  @override
  ConsumerState createState() => _AdvertisementImageState();
}

class _AdvertisementImageState
    extends BaseConsumerStatefulWidget<AdvertisementImage> {
  @override
  Widget build(BuildContext context) {
    final advertisementState = ref.watch(singleAdvertisementProvider);

    if (advertisementState.status != AdvertisementStatus.success ||
        advertisementState.data == null) {
      return buildSingleAdvertisementShimmer(context);
    }

    return GestureDetector(
      onTap: () {
        _navigateToPromotionScreen();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: AppValues.dimen_60.h,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(AppValues.dimen_10.r),
              ),
              child: CustomNetworkImage(
                imageUrl: advertisementState.data.image,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: AppValues.dimen_20.w),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppValues.dimen_12.r,
                  vertical: AppValues.dimen_8.r,
                ),
                decoration: BoxDecoration(
                  color: uiColors.light.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(AppValues.dimen_10.r),
                ),
                child: Text(
                  context.localization.visitNow,
                  style: appTextStyles.onImageShadowNovaRegular12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToPromotionScreen() {
    context.pushNamed(AppRoutes.promotion);
  }
}
