import 'package:dristi_open_source/core/base/base_consumer_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_global_texts.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/core/routes/app_routes.dart';
import 'package:dristi_open_source/features/on_boarding/providers/on_boarding_providers.dart';
import 'package:dristi_open_source/features/on_boarding/widgets/app_logo.dart';
import 'package:dristi_open_source/features/on_boarding/widgets/image_view_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class OnBoardingScreen extends ConsumerStatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  ConsumerState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState
    extends BaseConsumerStatefulWidget<OnBoardingScreen> {
  @override
  void initState() {
    super.initState();
    Future(() {
      _onBoardingStatus();
    });
  }

  void _onBoardingStatus() async {
    final isFirstTime =
        await ref.read(onBoardingProvider.notifier).getFirstTimeStatus();
    final inFirstTimeState = ref.read(inFirstTime.notifier);

    if (!isFirstTime) {
      _navigateToHomeScreen();
    } else {
      inFirstTimeState.state = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: uiColors.dark,
      body: Stack(
        children: [
          const ImageViewBuilder(hasDristiText: true),
          _buildButton(),
          AppLogoBuilder(),
        ],
      ),
    );
  }

  Widget _buildButton() {
    final inFirstTimeState = ref.watch(inFirstTime);

    if (!inFirstTimeState) {
      return const SizedBox.shrink();
    }

    return Positioned(
      bottom: AppValues.dimen_40.h,
      left: AppValues.dimen_0.w,
      right: AppValues.dimen_0.w,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppValues.dimen_28.w),
        child: ElevatedButton(
          style: ButtonStyle(
            padding: WidgetStatePropertyAll(
              EdgeInsets.symmetric(
                vertical: AppValues.dimen_16.r,
                horizontal: AppValues.dimen_16.r,
              ),
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppValues.dimen_16.r),
              ),
            ),
          ),
          onPressed: _navigateToSetLanguageScreen,
          child: Text(
            TextConstants.getStarted,
            style: appTextStyles.onImageNovaSemiBold16,
          ),
        ),
      ),
    );
  }

  void _navigateToSetLanguageScreen() {
    context.pushNamed(AppRoutes.setLanguage);
  }

  void _navigateToHomeScreen() {
    context.pushReplacementNamed(AppRoutes.appBaseScreen);
  }
}
