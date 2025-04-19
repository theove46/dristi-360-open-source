import 'package:dristi_open_source/core/base/base_consumer_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/core/global_providers/deep_linking/deep_linking_provider.dart';
import 'package:dristi_open_source/core/global_widgets/empty_list_image.dart';
import 'package:dristi_open_source/core/global_widgets/primary_snackbar.dart';
import 'package:dristi_open_source/core/routes/app_routes.dart';
import 'package:dristi_open_source/core/enums/app_language.dart';
import 'package:dristi_open_source/features/destination/providers/destination_data/destination_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class DestinationScreenBlogsBuilder extends ConsumerStatefulWidget {
  const DestinationScreenBlogsBuilder({super.key});

  @override
  ConsumerState createState() => _DestinationScreenBlogsBuilderState();
}

class _DestinationScreenBlogsBuilderState
    extends BaseConsumerStatefulWidget<DestinationScreenBlogsBuilder> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [_buildCommonBlogMessage(), _buildBlogsList()],
    );
  }

  Widget _buildBlogsList() {
    final destinationDataState = ref.watch(destinationProvider);
    final destinationDataStateData = destinationDataState.data;

    if (destinationDataStateData == null) {
      return const SizedBox.shrink();
    }

    final blogs = destinationDataStateData.blogs ?? [];

    if (blogs.isEmpty) {
      return const EmptyListImage();
    }

    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: blogs.length,
      itemBuilder: (context, index) {
        final blog = blogs[index];
        return GestureDetector(
          onTap: () {
            _openWebView(url: blog.url);
          },
          child: Card(
            color: uiColors.scrim,
            elevation: 1,
            margin: EdgeInsets.all(AppValues.dimen_8.h),
            shadowColor: uiColors.shadow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppValues.dimen_16.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: AppValues.dimen_10.h,
                horizontal: AppValues.dimen_16.r,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(blog.title, style: appTextStyles.secondaryNovaRegular16),
                  SizedBox(height: AppValues.dimen_10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        blog.author,
                        style: appTextStyles.primaryNovaRegular12,
                      ),
                      SizedBox(width: AppValues.dimen_10.w),
                      Text(
                        blog.site,
                        style: appTextStyles.secondaryNovaRegular12,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCommonBlogMessage() {
    return Container(
      padding: EdgeInsets.all(AppValues.dimen_10.r),
      margin: EdgeInsets.all(AppValues.dimen_10.r),
      decoration: BoxDecoration(
        border: Border.all(color: uiColors.primary),
        borderRadius: BorderRadius.circular(AppValues.dimen_10.r),
      ),
      child: RichText(
        text: TextSpan(
          text: '${context.localization.commonBlogMessage} ',
          style: appTextStyles.secondaryNovaRegular12,
          children: [
            TextSpan(
              text: context.localization.contactUs,
              style: appTextStyles.primaryNovaRegular12,
              recognizer:
                  TapGestureRecognizer()
                    ..onTap = () {
                      _navigateToPromotionScreen();
                    },
            ),
          ],
        ),
      ),
    );
  }

  void _openWebView({required String url}) async {
    final deepLinkingNotifier = ref.read(deepLinkingProvider.notifier);

    final webViewOpeningError = context.localization.somethingWentWrong;

    try {
      await deepLinkingNotifier.openSocialAccountsOrLinks(url: url);
    } catch (error) {
      _errorSnackBar(webViewOpeningError);
    }
  }

  void _navigateToPromotionScreen() {
    context.pushNamed(AppRoutes.promotion);
  }

  void _errorSnackBar(String message) async {
    ShowSnackBarMessage.showErrorSnackBar(message: message, context: context);
  }
}
