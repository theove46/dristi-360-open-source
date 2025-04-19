import 'package:dristi_open_source/core/base/base_consumer_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_assets.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/core/enums/app_language.dart';
import 'package:dristi_open_source/core/global_providers/language_settings/language_settings_provider.dart';
import 'package:dristi_open_source/core/global_widgets/asset_image_view.dart';
import 'package:dristi_open_source/core/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SpotScreenTopIcons extends ConsumerStatefulWidget {
  const SpotScreenTopIcons({
    required this.itemId,
    required this.isFavoriteProvider,
    required this.onFavoriteToggle,
    required this.languageToggle,
    super.key,
  });

  final String itemId;
  final bool Function(String) isFavoriteProvider;
  final void Function(String) onFavoriteToggle;
  final void Function(String) languageToggle;

  @override
  ConsumerState createState() => _SpotScreenTopIconsState();
}

class _SpotScreenTopIconsState
    extends BaseConsumerStatefulWidget<SpotScreenTopIcons> {
  @override
  Widget build(BuildContext context) {
    final isFavorite = widget.isFavoriteProvider(widget.itemId);

    return Positioned(
      top: AppValues.dimen_40.r,
      left: AppValues.dimen_10.r,
      right: AppValues.dimen_10.r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _buildNavigationIcon(
                icon: Assets.backward,
                color: uiColors.primary,
                onTap: () {
                  context.pop();
                },
              ),
              SizedBox(width: AppValues.dimen_20.w),
              _buildNavigationIcon(
                icon: Assets.home,
                color: uiColors.primary,
                onTap: () {
                  popUntilHome(context);
                },
              ),
            ],
          ),
          Row(
            children: [
              _buildNavigationIcon(
                icon: Assets.language,
                color: uiColors.primary,
                onTap: _showLanguagePopup,
              ),
              SizedBox(width: AppValues.dimen_20.w),
              _buildNavigationIcon(
                icon: isFavorite ? Assets.heartFill : Assets.heartOutlined,
                color: uiColors.error,
                onTap: () {
                  widget.onFavoriteToggle(widget.itemId);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationIcon({
    required String icon,
    required Color color,
    required Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Container(
        height: AppValues.dimen_40.r,
        width: AppValues.dimen_40.r,
        padding: EdgeInsets.all(AppValues.dimen_8.r),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: uiColors.light,
        ),
        child: AssetImageView(
          fileName: icon,
          height: AppValues.dimen_20.r,
          width: AppValues.dimen_20.r,
          color: color,
        ),
      ),
    );
  }

  void _showLanguagePopup() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            context.localization.chooseLanguage,
            style: appTextStyles.primaryNovaSemiBold16,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildChooseLanguageTile(
                AppLanguages.en.name,
                context.localization.english,
              ),
              _buildChooseLanguageTile(
                AppLanguages.bn.name,
                context.localization.bengali,
              ),
            ],
          ),
        );
      },
    );
  }

  RadioListTile<String> _buildChooseLanguageTile(String value, String title) {
    final currentLanguageState = ref.watch(currentDestinationLanguageProvider);

    return RadioListTile<String>(
      value: value,
      groupValue: currentLanguageState,
      title: Text(title, style: appTextStyles.secondaryNovaRegular16),
      onChanged: (value) {
        widget.languageToggle(value!);
        Navigator.pop(context);
      },
      activeColor: uiColors.primary,
      fillColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return uiColors.primary;
        }
        return uiColors.primary;
      }),
    );
  }
}
