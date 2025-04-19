import 'package:flutter/material.dart';

class UIColors {
  final BuildContext context;
  UIColors(this.context);

  Color transparent = Colors.transparent;

  Color get primary => Theme.of(context).colorScheme.primary;
  Color get onPrimary => Theme.of(context).colorScheme.onPrimary;

  Color get secondary => Theme.of(context).colorScheme.secondary;
  Color get onSecondary => Theme.of(context).colorScheme.onSecondary;

  Color get tertiary => Theme.of(context).colorScheme.tertiary;
  Color get onTertiary => Theme.of(context).colorScheme.onTertiary;

  Color get error => Theme.of(context).colorScheme.error;
  Color get onError => Theme.of(context).colorScheme.onError;

  Color get background =>
      Theme.of(context).colorScheme.surface; // set background

  Color get light => Theme.of(context).colorScheme.onSurface; // set light

  Color get shadow => Theme.of(context).colorScheme.shadow; // set shadow

  Color get dark => Theme.of(context).colorScheme.shadow; // set dark

  Color get scrim => Theme.of(context).colorScheme.scrim; // set scrim

  // Text Colors
  static Color primaryText(BuildContext context) =>
      Theme.of(context).colorScheme.onPrimary; // set primary text

  static Color secondaryText(BuildContext context) =>
      Theme.of(context).colorScheme.onSecondary; // set secondary text

  static Color tertiaryText(BuildContext context) =>
      Theme.of(context).colorScheme.onTertiary; // set blush text

  static Color errorText(BuildContext context) =>
      Theme.of(context).colorScheme.onError; // set error text

  static Color lightText(BuildContext context) =>
      Theme.of(context).colorScheme.onSurface; // set light text

  static Color darkText(BuildContext context) =>
      Theme.of(context).colorScheme.shadow; // set dark text

  // Component Colors
  static Color primaryComponent(BuildContext context) =>
      Theme.of(context).colorScheme.primary; // set Primary Color

  static List<Color> shimmerGradient(BuildContext context) => [
    Theme.of(context).colorScheme.inverseSurface,
    Theme.of(context).colorScheme.onInverseSurface,
    Theme.of(context).colorScheme.inverseSurface,
  ]; // set gradient
}
