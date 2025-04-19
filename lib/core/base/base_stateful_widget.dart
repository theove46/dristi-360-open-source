import 'package:dristi_open_source/core/styles/colors/colors.dart';
import 'package:dristi_open_source/core/styles/texts/texts.dart';
import 'package:flutter/material.dart';

abstract class BaseStatefulWidget<T extends StatefulWidget> extends State<T> {
  BaseStatefulWidget({Key? key});

  late UIColors uiColors;
  late AppTextStyles appTextStyles;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    uiColors = UIColors(context);
    appTextStyles = AppTextStyles(context);
  }
}
