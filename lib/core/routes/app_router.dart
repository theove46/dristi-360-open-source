import 'package:dristi_open_source/core/global_widgets/app_base_screen.dart';
import 'package:dristi_open_source/domain/entities/gallery_screen_entity.dart';
import 'package:dristi_open_source/core/global_widgets/error_screen.dart';
import 'package:dristi_open_source/core/global_widgets/web_view_screen.dart';
import 'package:dristi_open_source/core/routes/app_routes.dart';
import 'package:dristi_open_source/core/routes/navigation_helper.dart';
import 'package:dristi_open_source/core/enums/app_language.dart';
import 'package:dristi_open_source/features/accommodations_list/screens/accommodations_list_screen.dart';
import 'package:dristi_open_source/features/destinations_list/screens/destinations_list_screen.dart';
import 'package:dristi_open_source/features/districts/screens/districts_list_screen.dart';
import 'package:dristi_open_source/features/gallery/screens/gallery_screen.dart';
import 'package:dristi_open_source/features/gallery/screens/image_view_screen.dart';
import 'package:dristi_open_source/domain/entities/advertisement_entity.dart';
import 'package:dristi_open_source/features/home/home_screen/screens/home_screen.dart';
import 'package:dristi_open_source/features/accommodation/screens/accommodation_screen.dart';
import 'package:dristi_open_source/features/on_boarding/screens/on_boarding_screen.dart';
import 'package:dristi_open_source/features/promotion/screens/promotion_screen.dart';
import 'package:dristi_open_source/features/on_boarding/screens/set_language_screen.dart';
import 'package:dristi_open_source/features/settings/screens/settings_screen.dart';
import 'package:dristi_open_source/features/destination/screens/destination_screen.dart';
import 'package:dristi_open_source/features/travelling/screens/travelling_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class _Path {
  static const String onboarding = '/onboarding';
  static const String setLanguage = '/setLanguage';
  static const String home = '/home';
  static const String travelling = '/travelling';
  static const String appBaseScreen = '/bottomNavBar';
  static const String destination = '/destination/:destinationId/:instanceId';
  static const String destinationsList = '/destinationsList';
  static const String accommodation =
      '/accommodation/:accommodationId/:instanceId';
  static const String accommodationsList = '/accommodationsList';
  static const String districts = '/districts';
  static const String settings = '/settings';
  static const String gallery = '/gallery';
  static const String imageView = '/imageView';
  static const String promotion = '/promotion';
  static const String webView = '/webView';
  static const String error = '/error';
}

abstract class PathParameter {
  static const String destinationId = 'destinationId';
  static const String accommodationId = 'accommodationId';
  static const String instanceId = 'instanceId';
  static const String name = 'name';
  static const String images = 'images';
  static const String visible = 'true';
}

GoRouter appRouter = GoRouter(
  navigatorKey: NavigationHelper().parentNavigatorKey,
  initialLocation: _Path.onboarding,
  observers: [RouteNavigatorObserver()],
  routes: <RouteBase>[
    GoRoute(
      path: _Path.onboarding,
      name: AppRoutes.onboarding,
      builder: (context, state) => const OnBoardingScreen(),
    ),
    GoRoute(
      path: _Path.setLanguage,
      name: AppRoutes.setLanguage,
      builder: (context, state) => const SetLanguageScreen(),
    ),
    GoRoute(
      path: _Path.appBaseScreen,
      name: AppRoutes.appBaseScreen,
      builder: (context, state) => const AppBaseScreen(),
    ),
    GoRoute(
      path: _Path.home,
      name: AppRoutes.home,
      builder: (context, state) {
        final isVisibleString =
            state.uri.queryParameters[PathParameter.visible];
        final isVisible = isVisibleString == 'true';
        return HomeScreen(isVisible: isVisible);
      },
    ),
    GoRoute(
      path: _Path.travelling,
      name: AppRoutes.travelling,
      builder: (context, state) => const TravellingScreen(),
    ),
    GoRoute(
      path: _Path.destination,
      name: AppRoutes.destination,
      builder: (context, state) {
        final id = state.pathParameters[PathParameter.destinationId]!;
        final instanceId = state.pathParameters[PathParameter.instanceId]!;
        return DestinationScreen(id: id, instanceId: instanceId);
      },
    ),
    GoRoute(
      path: _Path.destinationsList,
      name: AppRoutes.destinationsList,
      builder: (context, state) {
        return const DestinationsListScreen();
      },
    ),
    GoRoute(
      path: _Path.accommodation,
      name: AppRoutes.accommodation,
      builder: (context, state) {
        final id = state.pathParameters[PathParameter.accommodationId]!;
        final instanceId = state.pathParameters[PathParameter.instanceId]!;
        return AccommodationScreen(id: id, instanceId: instanceId);
      },
    ),
    GoRoute(
      path: _Path.accommodationsList,
      name: AppRoutes.accommodationsList,
      builder: (context, state) {
        return const AccommodationsListScreen();
      },
    ),
    GoRoute(
      path: _Path.districts,
      name: AppRoutes.districts,
      builder: (context, state) => const DistrictsScreen(),
    ),
    GoRoute(
      path: _Path.settings,
      name: AppRoutes.settings,
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: _Path.gallery,
      name: AppRoutes.gallery,
      builder: (context, state) {
        return GalleryScreen(arguments: state.extra as GalleryScreenEntity);
      },
    ),
    GoRoute(
      path: _Path.imageView,
      name: AppRoutes.imageView,
      builder: (context, state) {
        return ImageViewerScreen(arguments: state.extra as GalleryScreenEntity);
      },
    ),
    GoRoute(
      path: _Path.promotion,
      name: AppRoutes.promotion,
      builder: (context, state) {
        return const PromotionScreen();
      },
    ),
    GoRoute(
      path: _Path.webView,
      name: AppRoutes.webView,
      builder: (BuildContext context, GoRouterState state) {
        final extra = state.extra;
        AdvertisementEntity? item;
        String? url;

        if (extra is AdvertisementEntity) {
          item = extra;
        } else if (extra is String) {
          url = extra;
        }

        return WebViewScreen(item: item, url: url);
      },
    ),
    GoRoute(
      path: _Path.error,
      name: AppRoutes.error,
      builder: (context, state) => const ErrorScreen(),
    ),
  ],
  errorPageBuilder: (context, state) {
    return MaterialPage<void>(
      key: state.pageKey,
      child: ErrorScreen(
        errorMessage: context.localization.pageNotFound,
        onPressed: () {
          context.pop();
        },
      ),
    );
  },
);

void popUntilHome(BuildContext context) {
  final router = GoRouter.of(context);
  while (router
          .routerDelegate
          .currentConfiguration
          .matches
          .last
          .matchedLocation !=
      _Path.home) {
    if (!context.canPop()) {
      return;
    }
    context.pop();
  }
}
