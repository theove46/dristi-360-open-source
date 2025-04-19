import 'package:carousel_slider/carousel_slider.dart';
import 'package:dristi_open_source/core/base/base_consumer_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/core/global_widgets/custom_network_image.dart';
import 'package:dristi_open_source/core/routes/app_routes.dart';
import 'package:dristi_open_source/core/global_widgets/shimmers.dart';
import 'package:dristi_open_source/features/home/advertisements/providers/advertisement_state.dart';
import 'package:dristi_open_source/features/home/home_screen/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AdvertisementBuilder extends ConsumerStatefulWidget {
  final bool isVisible;

  const AdvertisementBuilder({super.key, required this.isVisible});

  @override
  ConsumerState createState() => _ImageAdvertisementBuilderState();
}

class _ImageAdvertisementBuilderState
    extends BaseConsumerStatefulWidget<AdvertisementBuilder> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [_buildCarouselAdvertisement()]);
  }

  Widget _buildCarouselAdvertisement() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppValues.dimen_16.w,
      ).copyWith(top: AppValues.dimen_16.h),
      child: Stack(
        children: [
          _buildCarouselSlider(),
          Positioned(
            bottom: AppValues.dimen_16.h,
            right: AppValues.dimen_16.w,
            child: _buildAdvertisementIndicator(),
          ),
        ],
      ),
    );
  }

  Widget _buildCarouselSlider() {
    final currentAdvertisementNotifier = ref.read(
      currentAdvertisementProvider.notifier,
    );

    final carouselItems = ref.watch(multipleAdvertisementProvider);

    if (carouselItems.status != AdvertisementStatus.success ||
        carouselItems.data == null) {
      return buildHomeScreenAdvertisementShimmer(context);
    }

    return CarouselSlider.builder(
      itemCount: carouselItems.data.length,
      itemBuilder: (context, index, realIndex) {
        final item = carouselItems.data[index];
        return GestureDetector(
          onTap: () {
            _navigateToPromotionScreen();
          },
          child: SizedBox(
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(AppValues.dimen_10.r),
              ),
              child: CustomNetworkImage(imageUrl: item.image),
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: AppValues.dimen_130.h,
        aspectRatio: 2,
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: widget.isVisible,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(seconds: 2),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        onPageChanged: (index, reason) {
          currentAdvertisementNotifier.state = index;
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget _buildAdvertisementIndicator() {
    final currentAdvertisementState = ref.watch(currentAdvertisementProvider);
    final carouselItems = ref.watch(multipleAdvertisementProvider);

    if (carouselItems.status != AdvertisementStatus.success ||
        carouselItems.data == null) {
      return buildSliderIndicatorShimmer(context);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(carouselItems.data.length, (index) {
        double width;

        if (index == currentAdvertisementState) {
          width = AppValues.dimen_40.r;
        } else {
          width = AppValues.dimen_6.r;
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: AppValues.dimen_1.w),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            height: AppValues.dimen_6.r,
            width: width,
            decoration: BoxDecoration(
              color:
                  currentAdvertisementState == index
                      ? uiColors.light
                      : uiColors.light.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(AppValues.dimen_5.r),
            ),
          ),
        );
      }),
    );
  }

  void _navigateToPromotionScreen() {
    context.pushNamed(AppRoutes.promotion);
  }
}
