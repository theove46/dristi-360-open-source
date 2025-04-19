import 'package:dristi_open_source/core/base/base_consumer_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_assets.dart';
import 'package:dristi_open_source/core/enums/app_theme.dart';
import 'package:dristi_open_source/core/global_providers/theme_settings/theme_settings_provider.dart';
import 'package:dristi_open_source/core/enums/app_language.dart';
import 'package:dristi_open_source/features/settings/widgets/settings_bottom_sheet.dart';
import 'package:dristi_open_source/features/settings/widgets/settings_item.dart';
import 'package:dristi_open_source/domain/entities/sheet_items_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeSettings extends ConsumerStatefulWidget {
  const ThemeSettings({super.key});

  @override
  ConsumerState createState() => _ThemeSettingsState();
}

class _ThemeSettingsState extends BaseConsumerStatefulWidget<ThemeSettings> {
  @override
  Widget build(BuildContext context) {
    final themeState = ref.watch(themeProvider);

    return SettingsItems(
      icon: Assets.theme,
      title: context.localization.theme,
      subTitle: _getThemeText(themeState.data),
      onTap: () {
        _showSelectionBottomSheet(
          title: context.localization.theme,
          items: [
            SheetItemEntity(
              title: context.localization.systemDefault,
              value: AppTheme.systemDefault,
            ),
            SheetItemEntity(
              title: context.localization.light,
              value: AppTheme.light,
            ),
            SheetItemEntity(
              title: context.localization.dark,
              value: AppTheme.dark,
            ),
          ],
          selectedItem: themeState.data,
          onItemSelected: (value) {
            ref.read(themeProvider.notifier).setTheme(value);
          },
        );
      },
    );
  }

  String _getThemeText(AppTheme theme) {
    switch (theme) {
      case AppTheme.systemDefault:
        return context.localization.systemDefault;
      case AppTheme.light:
        return context.localization.light;
      case AppTheme.dark:
        return context.localization.dark;
    }
  }

  void _showSelectionBottomSheet<T>({
    required String title,
    required List<SheetItemEntity<T>> items,
    required T selectedItem,
    required Function(dynamic) onItemSelected,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SettingsBottomSheet(
          title: title,
          items: items,
          selectedItem: selectedItem,
          onItemSelected: onItemSelected,
        );
      },
    );
  }
}
