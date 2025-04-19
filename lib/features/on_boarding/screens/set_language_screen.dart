import 'package:dristi_open_source/core/base/base_consumer_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_global_texts.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/core/global_providers/language_settings/language_settings_provider.dart';
import 'package:dristi_open_source/core/routes/app_routes.dart';
import 'package:dristi_open_source/core/global_widgets/primary_snackbar.dart';
import 'package:dristi_open_source/core/enums/app_language.dart';
import 'package:dristi_open_source/features/on_boarding/providers/on_boarding_providers.dart';
import 'package:dristi_open_source/features/on_boarding/providers/on_boarding_state.dart';
import 'package:dristi_open_source/features/on_boarding/widgets/app_logo.dart';
import 'package:dristi_open_source/features/on_boarding/widgets/image_view_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SetLanguageScreen extends ConsumerStatefulWidget {
  const SetLanguageScreen({super.key});

  @override
  ConsumerState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState
    extends BaseConsumerStatefulWidget<SetLanguageScreen> {
  @override
  void initState() {
    super.initState();
    Future(() {
      _onBoardingStatus();
      _showLanguageBottomSheet();
    });
  }

  void _onBoardingStatus() async {
    final isFirstTime =
        await ref.read(onBoardingProvider.notifier).getFirstTimeStatus();
    final inFirstTimeState = ref.read(inFirstTime.notifier);

    if (!isFirstTime) {
      if (mounted) {
        _navigateToHomeScreen();
      }
    } else {
      inFirstTimeState.state = true;
    }
  }

  void _showLanguageBottomSheet() {
    Future.delayed(Duration(milliseconds: 300), () {
      if (!mounted) return;

      showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: true,
        backgroundColor: uiColors.light,

        builder: (context) {
          return _buildBottomSheet();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(onBoardingProvider, (_, next) {
      if (next.status == OnBoardingStatus.success) {
        _navigateToHomeScreen();
      } else if (next.status == OnBoardingStatus.failure) {
        ShowSnackBarMessage.showErrorSnackBar(
          message: next.errorMessage!,
          context: context,
        );
      }
    });

    return Scaffold(
      backgroundColor: uiColors.dark,
      body: Stack(
        children: [
          Opacity(
            opacity: AppValues.dimen_0_5,
            child: ImageViewBuilder(hasDristiText: false),
          ),
          _buildWelcomeText(),
          AppLogoBuilder(),
        ],
      ),
    );
  }

  Widget _buildWelcomeText() {
    return Positioned(
      top: AppValues.dimen_120.h,
      left: AppValues.dimen_28.r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(TextConstants.welcome, style: appTextStyles.onImageNovaBold40),
          Text(
            TextConstants.getStarted,
            style: appTextStyles.onImageNovaBold24,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheet() {
    final languageState = ref.watch(languageProvider);

    return SizedBox(
      height: AppValues.dimen_280.h,
      child: Padding(
        padding: EdgeInsets.all(AppValues.dimen_16.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              TextConstants.setLanguage,
              style: appTextStyles.darkNovaSemiBold20,
            ),
            SizedBox(height: AppValues.dimen_20.h),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLanguageButton(
                  language: AppLanguages.bn,
                  isSelected: languageState.language == AppLanguages.bn,
                ),
                SizedBox(height: AppValues.dimen_10.h),
                _buildLanguageButton(
                  language: AppLanguages.en,
                  isSelected: languageState.language == AppLanguages.en,
                ),
              ],
            ),
            SizedBox(height: AppValues.dimen_20.h),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageButton({
    required AppLanguages language,
    required bool isSelected,
  }) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: WidgetStatePropertyAll(0),
        backgroundColor: WidgetStatePropertyAll(
          isSelected ? null : uiColors.light,
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppValues.dimen_16.r),
            side: BorderSide(color: uiColors.dark),
          ),
        ),
      ),
      onPressed: () {
        ref.read(languageProvider.notifier).setLanguage(language);
      },
      child: Text(
        _getLanguageText(language),
        style: appTextStyles.onImageNovaSemiBold16.copyWith(
          color: isSelected ? null : uiColors.dark,
        ),
      ),
    );
  }

  String _getLanguageText(AppLanguages language) {
    switch (language) {
      case AppLanguages.en:
        return context.localization.english;
      case AppLanguages.bn:
        return context.localization.bengali;
    }
  }

  Widget _buildSubmitButton() {
    final notifier = ref.read(onBoardingProvider.notifier);
    final inFirstTimeState = ref.watch(inFirstTime);

    if (!inFirstTimeState) {
      return const SizedBox.shrink();
    }

    return Align(
      alignment: Alignment.topRight,
      child: TextButton(
        onPressed: notifier.homeScreenNavigationSubmit,
        child: Text(
          TextConstants.submit,
          style: appTextStyles.darkNovaSemiBold16,
        ),
      ),
    );
  }

  void _navigateToHomeScreen() {
    context.goNamed(AppRoutes.appBaseScreen);
  }
}
