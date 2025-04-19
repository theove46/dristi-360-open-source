import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,

  // primary
  primary: Color(0xFF274c77), // set primary
  onPrimary: Color(0xFF274c77), // set primary text
  // secondary
  secondary: Color(0xFFe7ecef), // set secondary
  onSecondary: Color(0xff333333), // set secondary text
  // tertiary
  tertiary: Color(0xFF6096ba), // set tertiary
  onTertiary: Color(0xFF6d6e70), // set blush text
  // error
  error: Color(0xffEA5455), // set error
  onError: Color(0xffEA5455), // set error text

  surface: Color(0xFFe7ecef), // set background
  onSurface: Color(0xFFe7ecef), // set light

  inverseSurface: Color(0xFFEBEBF4), // set gradient
  onInverseSurface: Color(0xFFF4F4F4), // set gradient

  scrim: Color(0xFFdee1ec), // set scrim

  outline: Color(0xFF274c77), // set outline

  shadow: Color(0xFF274c77), // set dark
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,

  // primary
  primary: Color(0xFF54d2d2), // set primary
  onPrimary: Color(0xFF54d2d2), // set primary text
  // secondary
  secondary: Color(0xFF072448), // set secondary
  onSecondary: Color(0xFFdaeaf6), // set secondary text
  // tertiary
  tertiary: Color(0xFFdaeaf6), // set tertiary
  onTertiary: Color(0xFFd9dad7), // set blush text
  // error
  error: Color(0xffff304f), // set error
  onError: Color(0xffff304f), // set error text

  surface: Color(0xFF072448), // set background
  onSurface: Color(0xFFdaeaf6), // set light

  inverseSurface: Color(0xFF183661), // set gradient
  onInverseSurface: Color(0xFF1c4b82), // set gradient

  scrim: Color(0xFF092F5D), // set scrim

  outline: Color(0xFF54d2d2), // set outline

  shadow: Color(0xFF072448), // set dark
);
