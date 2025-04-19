import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/core/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

Widget buildShimmer({
  required BuildContext context,
  required double height,
  required double width,
  Widget? child,
}) {
  final gradient = LinearGradient(
    colors: UIColors.shimmerGradient(context),
    begin: const Alignment(-1.0, -0.3),
    end: const Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
    stops: const [0.1, 0.3, 0.4],
  );

  return Shimmer(
    gradient: gradient,
    child: SizedBox(height: height, width: width, child: child),
  );
}

Widget buildShimmerContainer({
  required BuildContext context,
  required double height,
  required double width,
  required double borderRadius,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(borderRadius),
    child: Container(
      height: height,
      width: width,
      color: UIColors.lightText(context),
    ),
  );
}

Widget buildSquareHorizontalListShimmer({
  required BuildContext context,
  required double height,
  required double itemSize,
  required int itemCount,
}) {
  return buildShimmer(
    context: context,
    height: height,
    width: double.infinity,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(right: AppValues.dimen_8.w),
          child: Column(
            children: [
              buildShimmerContainer(
                context: context,
                height: itemSize,
                width: itemSize,
                borderRadius: AppValues.dimen_16.r,
              ),
              SizedBox(height: AppValues.dimen_4.h),
              buildShimmerContainer(
                context: context,
                height: AppValues.dimen_10.r,
                width: itemSize,
                borderRadius: AppValues.dimen_6.r,
              ),
            ],
          ),
        );
      },
    ),
  );
}

Widget buildListViewShimmer({
  required BuildContext context,
  required double height,
  required double width,
  required int itemCount,
}) {
  return SliverList(
    delegate: SliverChildBuilderDelegate((context, index) {
      return buildShimmer(
        context: context,
        height: height,
        width: width,
        child: Padding(
          padding: EdgeInsets.only(
            left: AppValues.dimen_16.r,
            right: AppValues.dimen_16.r,
            top: AppValues.dimen_16.r,
          ),
          child: buildShimmerContainer(
            context: context,
            height: height,
            width: width,
            borderRadius: AppValues.dimen_16.r,
          ),
        ),
      );
    }, childCount: itemCount),
  );
}

Widget buildGridViewShimmer({
  required BuildContext context,
  required double height,
  required double width,
  required int itemCount,
}) {
  return SliverGrid(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: width / height,
    ),
    delegate: SliverChildBuilderDelegate((context, index) {
      return buildShimmer(
        context: context,
        height: height,
        width: width,
        child: Padding(
          padding: EdgeInsets.only(
            left: AppValues.dimen_8.r,
            right: AppValues.dimen_8.r,
            top: AppValues.dimen_8.r,
            bottom: AppValues.dimen_16.r,
          ),
          child: buildShimmerContainer(
            context: context,
            height: height,
            width: width,
            borderRadius: AppValues.dimen_16.r,
          ),
        ),
      );
    }, childCount: itemCount),
  );
}

Widget buildHomeScreenSliderShimmer(BuildContext context) {
  return buildShimmer(
    context: context,
    height: AppValues.dimen_220.h,
    width: double.infinity,
    child: Container(
      margin: EdgeInsets.all(AppValues.dimen_1.r),
      child: buildShimmerContainer(
        context: context,
        height: AppValues.dimen_220.h,
        width: double.infinity,
        borderRadius: AppValues.dimen_10.r,
      ),
    ),
  );
}

Widget buildSingleAdvertisementShimmer(BuildContext context) {
  return buildShimmer(
    context: context,
    height: AppValues.dimen_60.h,
    width: double.infinity,
    child: buildShimmerContainer(
      context: context,
      height: AppValues.dimen_60.h,
      width: double.infinity,
      borderRadius: AppValues.dimen_10.r,
    ),
  );
}

Widget buildHomeScreenAdvertisementShimmer(BuildContext context) {
  return buildShimmer(
    context: context,
    height: AppValues.dimen_130.h,
    width: double.infinity,
    child: Container(
      margin: EdgeInsets.all(AppValues.dimen_1.r),
      padding: EdgeInsets.only(top: AppValues.dimen_16.h),
      child: buildShimmerContainer(
        context: context,
        height: AppValues.dimen_120.h,
        width: double.infinity,
        borderRadius: AppValues.dimen_10.r,
      ),
    ),
  );
}

Widget buildHomeScreenCategoriesShimmer(BuildContext context) {
  return Container(
    height: AppValues.dimen_240.h,
    width: AppValues.dimen_1.sw,
    margin: EdgeInsets.all(AppValues.dimen_2.r),
    padding: EdgeInsets.all(AppValues.dimen_16.r),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(AppValues.dimen_10.r)),
      border: Border.all(
        color: UIColors.primaryComponent(context).withValues(alpha: 0.5),
        width: 2.r,
      ),
    ),
    child: Align(
      alignment: Alignment.topCenter,
      child: Wrap(
        runSpacing: 10.r,
        spacing: 10.r,
        children: List.generate(
          8,
          (index) => Shimmer(
            gradient: LinearGradient(
              colors: UIColors.shimmerGradient(context),
              begin: const Alignment(-1.0, -0.3),
              end: const Alignment(1.0, 0.3),
              tileMode: TileMode.clamp,
              stops: const [0.1, 0.3, 0.4],
            ),
            child: SizedBox(
              width: AppValues.dimen_75.w,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: AppValues.dimen_10.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildShimmerContainer(
                      context: context,
                      width: AppValues.dimen_60.r,
                      height: AppValues.dimen_60.r,
                      borderRadius: AppValues.dimen_6.r,
                    ),
                    SizedBox(height: AppValues.dimen_4.h),
                    buildShimmerContainer(
                      context: context,
                      width: AppValues.dimen_60.r,
                      height: AppValues.dimen_10.r,
                      borderRadius: AppValues.dimen_6.r,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget buildHomeScreenTopDestinationsShimmer(BuildContext context) {
  return buildSquareHorizontalListShimmer(
    context: context,
    height: AppValues.dimen_100.h,
    itemSize: AppValues.dimen_80.r,
    itemCount: 6,
  );
}

Widget buildHomeScreenPopularDistrictsShimmer(BuildContext context) {
  return buildSquareHorizontalListShimmer(
    context: context,
    height: AppValues.dimen_150.h,
    itemSize: AppValues.dimen_130.r,
    itemCount: 6,
  );
}

Widget buildSliderIndicatorShimmer(BuildContext context) {
  return buildShimmer(
    context: context,
    height: AppValues.dimen_8.h,
    width: AppValues.dimen_80.r,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        double width;

        if (index == 0) {
          width = AppValues.dimen_40.r;
        } else {
          width = AppValues.dimen_6.r;
        }
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: AppValues.dimen_1.w),
          child: buildShimmerContainer(
            context: context,
            height: AppValues.dimen_6.r,
            width: width,
            borderRadius: AppValues.dimen_5.r,
          ),
        );
      }),
    ),
  );
}

Widget buildDestinationsListShimmer(BuildContext context) {
  return buildGridViewShimmer(
    context: context,
    height: AppValues.dimen_100.r,
    width: AppValues.dimen_80.r,
    itemCount: 6,
  );
}

Widget buildAccommodationsListShimmer(BuildContext context) {
  return buildListViewShimmer(
    context: context,
    height: AppValues.dimen_160.r,
    width: double.infinity,
    itemCount: 6,
  );
}

Widget buildDistrictsListShimmer(BuildContext context) {
  return buildGridViewShimmer(
    context: context,
    height: AppValues.dimen_30.r,
    width: AppValues.dimen_80.r,
    itemCount: 12,
  );
}

Widget buildFullScreenShimmer(BuildContext context) {
  return buildShimmer(
    context: context,
    width: double.infinity,
    height: double.infinity,
    child: Container(
      width: double.infinity,
      height: double.infinity,
      color: UIColors.tertiaryText(context),
    ),
  );
}
