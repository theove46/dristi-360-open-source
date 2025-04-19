import 'package:dristi_open_source/core/base/base_consumer_stateful_widget.dart';
import 'package:dristi_open_source/core/constants/app_values.dart';
import 'package:dristi_open_source/core/global_providers/favourites_items/favourites_items_provider.dart';
import 'package:dristi_open_source/core/global_providers/language_settings/language_settings_provider.dart';
import 'package:dristi_open_source/core/global_widgets/advertisement_image.dart';
import 'package:dristi_open_source/core/global_widgets/shimmers.dart';
import 'package:dristi_open_source/core/global_widgets/spot_screen_image.dart';
import 'package:dristi_open_source/core/global_widgets/spot_screen_top_icons.dart';
import 'package:dristi_open_source/core/enums/app_language.dart';
import 'package:dristi_open_source/features/home/home_screen/providers/home_provider.dart';
import 'package:dristi_open_source/features/accommodation/providers/accommodation_data/accommodation_provider.dart';
import 'package:dristi_open_source/features/accommodation/widgets/accommodation_details_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccommodationScreen extends ConsumerStatefulWidget {
  const AccommodationScreen({
    required this.id,
    required this.instanceId,
    super.key,
  });

  final String id;
  final String instanceId;

  @override
  ConsumerState createState() => _AccommodationScreenState();
}

class _AccommodationScreenState
    extends BaseConsumerStatefulWidget<AccommodationScreen> {
  @override
  void initState() {
    super.initState();

    Future(() {
      _fetchComponents(null);
    });
  }

  @override
  void dispose() {
    ref.read(currentDestinationLanguageProvider.notifier).state = '';
    super.dispose();
  }

  Future<void> _fetchComponents(String? language) async {
    final appLanguageState =
        ref.watch(languageProvider).language.toLanguage.languageCode;

    final currentLanguageNotifier = ref.read(
      currentDestinationLanguageProvider.notifier,
    );

    if (language == null) {
      currentLanguageNotifier.state = appLanguageState;
    } else {
      currentLanguageNotifier.state = language;
    }

    final currentLanguageState = ref.watch(currentDestinationLanguageProvider);

    ref
        .read(accommodationProvider.notifier)
        .getAccommodationData(currentLanguageState, widget.id);
    ref
        .read(singleAdvertisementProvider.notifier)
        .getSingleAdvertisementComponents();
  }

  @override
  Widget build(BuildContext context) {
    final accommodationDataState = ref.watch(accommodationProvider);

    if (accommodationDataState.data == null) {
      return buildFullScreenShimmer(context);
    }

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          final currentLanguageState = ref.watch(
            currentDestinationLanguageProvider,
          );

          return _fetchComponents(currentLanguageState);
        },
        child: Stack(
          children: [
            SpotScreenImage(stateData: accommodationDataState.data),
            _buildDescription(),
            SpotScreenTopIcons(
              itemId: widget.id,
              isFavoriteProvider:
                  (id) => ref
                      .watch(favouriteItemsProvider)
                      .data
                      .contains(widget.id),
              onFavoriteToggle: (id) {
                ref
                    .read(favouriteItemsProvider.notifier)
                    .toggleFavouritesItems(widget.id);
              },
              languageToggle: (language) {
                _fetchComponents(language);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: uiColors.secondary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppValues.dimen_20.r),
              topRight: Radius.circular(AppValues.dimen_20.r),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: EdgeInsets.all(AppValues.dimen_16.r),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AdvertisementImage(),
                  AccommodationScreenDetailsBuilder(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
