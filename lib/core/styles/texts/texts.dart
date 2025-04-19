import 'package:dristi_open_source/core/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FontFamily {
  static const String nova = 'Nova';
  static const String nunito = 'Nunito';
  static const String vibes = 'Vibes';
}

class AppTextStyles {
  final BuildContext context;
  AppTextStyles(this.context);

  /// Font Weights
  final TextStyle _regular = const TextStyle(fontWeight: FontWeight.w500);
  final TextStyle _semiBold = const TextStyle(fontWeight: FontWeight.w600);
  final TextStyle _bold = const TextStyle(fontWeight: FontWeight.w700);

  /// Font Families
  TextStyle get _novaRegular =>
      _regular.copyWith(fontFamily: FontFamily.nunito);
  TextStyle get _novaSemiBold =>
      _semiBold.copyWith(fontFamily: FontFamily.nunito);
  TextStyle get _novaBold => _bold.copyWith(fontFamily: FontFamily.nunito);
  TextStyle get _vibesBold => _bold.copyWith(fontFamily: FontFamily.vibes);

  /// Font Colors
  TextStyle get primaryNovaRegular =>
      _novaRegular.copyWith(color: UIColors.primaryText(context));

  TextStyle get primaryNovaSemiBold =>
      _novaSemiBold.copyWith(color: UIColors.primaryText(context));

  TextStyle get primaryNovaBold =>
      _novaBold.copyWith(color: UIColors.primaryText(context));

  TextStyle get secondaryNovaRegular =>
      _novaRegular.copyWith(color: UIColors.secondaryText(context));

  TextStyle get secondaryNovaSemiBold =>
      _novaSemiBold.copyWith(color: UIColors.secondaryText(context));

  TextStyle get errorNovaRegular =>
      _novaRegular.copyWith(color: UIColors.errorText(context));

  TextStyle get errorNovaBold =>
      _novaBold.copyWith(color: UIColors.errorText(context));

  TextStyle get blushNovaRegular =>
      _novaRegular.copyWith(color: UIColors.tertiaryText(context));

  TextStyle get onImageShadowNovaRegular =>
      _novaRegular.copyWith(color: UIColors.darkText(context));

  TextStyle get darkNovaBold =>
      _novaBold.copyWith(color: UIColors.darkText(context));

  TextStyle get darkNovaSemiBold =>
      _novaSemiBold.copyWith(color: UIColors.darkText(context));

  TextStyle get onImageNovaRegular =>
      _novaRegular.copyWith(color: UIColors.lightText(context));

  TextStyle get onImageNovaSemiBold =>
      _novaSemiBold.copyWith(color: UIColors.lightText(context));

  TextStyle get onImageNovaBold =>
      _novaBold.copyWith(color: UIColors.lightText(context));

  TextStyle get onImageVibesBold =>
      _vibesBold.copyWith(color: UIColors.lightText(context));

  TextStyle get onImageShadow => onImageVibesBold.copyWith(
    shadows: [
      Shadow(
        offset: const Offset(3.0, 3.0),
        blurRadius: 2.0,
        color: UIColors.darkText(context),
      ),
    ],
  );

  /// Font Sizes

  // Primary Color texts

  TextStyle get primaryNovaRegular12 =>
      primaryNovaRegular.copyWith(fontSize: 12.sp);

  TextStyle get primaryNovaSemiBold12 =>
      primaryNovaSemiBold.copyWith(fontSize: 12.sp);

  TextStyle get primaryNovaRegular16 =>
      primaryNovaRegular.copyWith(fontSize: 16.sp);

  TextStyle get primaryNovaSemiBold16 =>
      primaryNovaSemiBold.copyWith(fontSize: 16.sp);

  TextStyle get primaryNovaBold16 => primaryNovaBold.copyWith(fontSize: 16.sp);

  TextStyle get primaryNovaBold20 => primaryNovaBold.copyWith(fontSize: 20.sp);

  TextStyle get primaryNovaBold28 => primaryNovaBold.copyWith(fontSize: 28.sp);

  // Secondary Color texts

  TextStyle get secondaryNovaRegular12 =>
      secondaryNovaRegular.copyWith(fontSize: 12.sp);

  TextStyle get secondaryNovaSemiBold12 =>
      secondaryNovaSemiBold.copyWith(fontSize: 12.sp);

  TextStyle get secondaryNovaRegular16 =>
      secondaryNovaRegular.copyWith(fontSize: 16.sp);

  TextStyle get secondaryNovaSemiBold10 =>
      secondaryNovaSemiBold.copyWith(fontSize: 10.sp);

  TextStyle get secondaryNovaSemiBold20 =>
      secondaryNovaSemiBold.copyWith(fontSize: 20.sp);

  // Error / Always Red Color texts

  TextStyle get errorNovaRegular12 =>
      errorNovaRegular.copyWith(fontSize: 12.sp);

  TextStyle get errorNovaBold16 => errorNovaBold.copyWith(fontSize: 16.sp);

  // Blush / Grey color

  TextStyle get blushNovaRegular12 =>
      blushNovaRegular.copyWith(fontSize: 12.sp);

  // Shadow color

  TextStyle get onImageShadowNovaRegular12 =>
      onImageShadowNovaRegular.copyWith(fontSize: 12.sp);

  TextStyle get darkNovaBold12 => darkNovaBold.copyWith(fontSize: 12.sp);

  TextStyle get darkNovaSemiBold16 =>
      darkNovaSemiBold.copyWith(fontSize: 16.sp);

  TextStyle get darkNovaSemiBold20 =>
      darkNovaSemiBold.copyWith(fontSize: 20.sp);

  // OnImage / Always White Color texts

  TextStyle get onImageNovaRegular8 =>
      onImageNovaRegular.copyWith(fontSize: 8.sp);

  TextStyle get onImageNovaRegular12 =>
      onImageNovaRegular.copyWith(fontSize: 12.sp);

  TextStyle get onImageNovaRegular36 =>
      onImageNovaRegular.copyWith(fontSize: 36.sp);

  TextStyle get onImageNovaSemiBold12 =>
      onImageNovaSemiBold.copyWith(fontSize: 12.sp);

  TextStyle get onImageNovaSemiBold16 =>
      onImageNovaSemiBold.copyWith(fontSize: 16.sp);

  TextStyle get onImageNovaBold12 => onImageNovaBold.copyWith(fontSize: 12.sp);

  TextStyle get onImageNovaBold24 => onImageNovaBold.copyWith(fontSize: 20.sp);

  TextStyle get onImageNovaBold28 => onImageNovaBold.copyWith(fontSize: 28.sp);

  TextStyle get onImageNovaBold32 => onImageNovaBold.copyWith(fontSize: 32.sp);

  TextStyle get onImageNovaBold40 => onImageNovaBold.copyWith(fontSize: 40.sp);

  TextStyle get onImageBoldShadow32 => onImageShadow.copyWith(fontSize: 32.sp);

  TextStyle get onImageBoldShadow44 => onImageShadow.copyWith(fontSize: 44.sp);

  TextStyle get onImageBoldShadow60 => onImageShadow.copyWith(fontSize: 60.sp);
}
