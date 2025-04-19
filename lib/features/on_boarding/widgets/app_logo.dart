import 'package:dristi_open_source/core/base/base_consumer_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_assets.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/core/global_widgets/asset_image_view.dart';
import 'package:dristi_open_source/features/on_boarding/providers/on_boarding_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLogoBuilder extends ConsumerStatefulWidget {
  const AppLogoBuilder({super.key});

  @override
  ConsumerState createState() => _AppLogoState();
}

class _AppLogoState extends BaseConsumerStatefulWidget<AppLogoBuilder> {
  @override
  Widget build(BuildContext context) {
    final inFirstTimeState = ref.watch(inFirstTime);

    return Padding(
      padding: EdgeInsets.only(
        top: AppValues.dimen_48.r,
        left: AppValues.dimen_28.r,
      ),
      child: Align(
        alignment: inFirstTimeState ? Alignment.topLeft : Alignment.center,
        child: ClipOval(
          child: Container(
            color: uiColors.light,
            child: AssetImageView(
              fileName: Assets.logo,
              height:
                  inFirstTimeState
                      ? AppValues.dimen_60.r
                      : AppValues.dimen_120.r,
              width:
                  inFirstTimeState
                      ? AppValues.dimen_60.r
                      : AppValues.dimen_120.r,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
