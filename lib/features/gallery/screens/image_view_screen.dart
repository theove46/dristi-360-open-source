import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dristi_open_source/core/base/base_consumer_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_assets.dart';
import 'package:dristi_open_source/core/constants/app_global_texts.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/domain/entities/gallery_screen_entity.dart';
import 'package:dristi_open_source/core/global_widgets/asset_image_view.dart';
import 'package:dristi_open_source/core/global_widgets/primary_snackbar.dart';
import 'package:dristi_open_source/core/enums/app_language.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gal/gal.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageViewerScreen extends ConsumerStatefulWidget {
  final GalleryScreenEntity? arguments;

  const ImageViewerScreen({required this.arguments, super.key});

  @override
  ConsumerState createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState
    extends BaseConsumerStatefulWidget<ImageViewerScreen> {
  late PageController _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.arguments!.initialIndex;
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: AssetImageView(
            fileName: Assets.backward,
            height: AppValues.dimen_32.r,
            width: AppValues.dimen_32.r,
            color: uiColors.primary,
          ),
          onPressed: () {
            context.pop();
          },
        ),
        actions: [
          IconButton(
            icon: AssetImageView(
              fileName: Assets.download,
              height: AppValues.dimen_32.r,
              width: AppValues.dimen_32.r,
              color: uiColors.primary,
            ),
            onPressed: () async {
              final path =
                  '${Directory.systemTemp.path}/${widget.arguments!.galleryName}_${currentIndex}_${context.localization.credit}.jpg';
              final url = widget.arguments!.images[currentIndex].url;
              await Dio().download(url, path);
              await Gal.putImage(path, album: TextConstants.appName);
              _successSnackBar();
            },
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [_buildImageView(), _buildCredit(), _buildIndicatorsList()],
      ),
    );
  }

  Widget _buildCredit() {
    final credit = widget.arguments!.images[currentIndex].credit;

    if (credit.isEmpty) {
      return const SizedBox.shrink();
    }

    return Positioned(
      bottom: AppValues.dimen_80.r,
      left: AppValues.dimen_16.r,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.copyright,
            size: AppValues.dimen_20.r,
            color: uiColors.primary,
          ),
          SizedBox(width: AppValues.dimen_8.r),
          Text(credit, style: appTextStyles.secondaryNovaRegular16),
        ],
      ),
    );
  }

  Widget _buildImageView() {
    return PhotoViewGallery.builder(
      pageController: _pageController,
      itemCount: widget.arguments!.images.length,
      builder: (context, index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: CachedNetworkImageProvider(
            widget.arguments!.images[index].url,
          ),
          minScale: PhotoViewComputedScale.contained * 0.6,
          maxScale: PhotoViewComputedScale.covered * 2,
        );
      },
      scrollPhysics: const BouncingScrollPhysics(),
      backgroundDecoration: BoxDecoration(color: uiColors.background),
      enableRotation: true,
      onPageChanged: (index) {
        setState(() {
          currentIndex = index;
        });
      },
    );
  }

  Widget _buildIndicatorsList() {
    if (widget.arguments!.images.length == 1) {
      return const SizedBox.shrink();
    }

    return Positioned(
      bottom: AppValues.dimen_20.r,
      left: AppValues.dimen_16.r,
      right: AppValues.dimen_16.r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: AssetImageView(
              fileName: Assets.backward,
              height: AppValues.dimen_32.r,
              width: AppValues.dimen_32.r,
              color: currentIndex > 0 ? uiColors.primary : uiColors.tertiary,
            ),
            onPressed: () {
              if (currentIndex > 0) {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.arguments!.images.length,
              (index) => _buildCircleIndicator(index == currentIndex),
            ),
          ),
          IconButton(
            icon: AssetImageView(
              fileName: Assets.forward,
              height: AppValues.dimen_32.r,
              width: AppValues.dimen_32.r,
              color:
                  currentIndex < (widget.arguments!.images.length - 1)
                      ? uiColors.primary
                      : uiColors.tertiary,
            ),
            onPressed: () {
              if (currentIndex < widget.arguments!.images.length - 1) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCircleIndicator(bool isActive) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppValues.dimen_4.r),
      width: isActive ? AppValues.dimen_8.r : AppValues.dimen_6.r,
      height: isActive ? AppValues.dimen_8.r : AppValues.dimen_6.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? uiColors.primary : uiColors.tertiary,
      ),
    );
  }

  void _successSnackBar() async {
    ShowSnackBarMessage.showSuccessSnackBar(
      message: context.localization.successfullyDownloaded,
      context: context,
    );
  }
}
