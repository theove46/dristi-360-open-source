import 'package:dristi_open_source/core/base/base_consumer_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_assets.dart';
import 'package:dristi_open_source/core/constants/app_global_texts.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/core/global_widgets/custom_network_image.dart';
import 'package:dristi_open_source/domain/entities/gallery_screen_entity.dart';
import 'package:dristi_open_source/domain/entities/images_entity.dart';
import 'package:dristi_open_source/core/global_widgets/asset_image_view.dart';
import 'package:dristi_open_source/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SpotScreenImage extends ConsumerStatefulWidget {
  const SpotScreenImage({required this.stateData, super.key});

  final dynamic stateData;

  @override
  ConsumerState createState() => _SpotScreenImageState();
}

class _SpotScreenImageState
    extends BaseConsumerStatefulWidget<SpotScreenImage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        _buildBackgroundImage(),
        _buildDestinationText(),
        _buildGalleryIcon(),
      ],
    );
  }

  Widget _buildBackgroundImage() {
    return Hero(
      tag: "${TextConstants.appName}-${widget.stateData.id}",
      child: ClipRRect(
        child: CustomNetworkImage(
          imageUrl: widget.stateData.images!.first.url,
          height: AppValues.dimen_500.h,
          width: double.infinity,
        ),
      ),
    );
  }

  Widget _buildGalleryIcon() {
    return Positioned(
      top: AppValues.dimen_320.h,
      left: AppValues.dimen_16.w,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _navigateToGallery,
        child: Container(
          padding: EdgeInsets.all(AppValues.dimen_3.r),
          height: AppValues.dimen_75.r,
          width: AppValues.dimen_75.r,
          decoration: BoxDecoration(
            color: uiColors.light,
            borderRadius: BorderRadius.circular(AppValues.dimen_12.r),
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppValues.dimen_10.r),
                child: SizedBox.fromSize(
                  size: Size.fromRadius(AppValues.dimen_48.r),
                  child: CustomNetworkImage(
                    imageUrl: widget.stateData.images!.first.url,
                  ),
                ),
              ),
              Center(
                child: AssetImageView(
                  fileName: Assets.gallery,
                  height: AppValues.dimen_40.r,
                  width: AppValues.dimen_40.r,
                  color: uiColors.light,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDestinationText() {
    return Positioned(
      top: AppValues.dimen_320.h,
      right: AppValues.dimen_16.w,
      child: Transform.rotate(
        angle: -15 * (3.1415926535 / 180),
        child: Text(
          widget.stateData.onImageTitle,
          style: appTextStyles.onImageBoldShadow44,
        ),
      ),
    );
  }

  void _navigateToGallery() {
    final List<ImagesEntity> images = widget.stateData.images ?? [];
    context.pushNamed(
      AppRoutes.gallery,
      extra: GalleryScreenEntity(
        galleryName: widget.stateData.title,
        images: images,
      ),
    );
  }
}
