import 'package:dristi_open_source/core/global_providers/favourites_items/favourites_items_notifier.dart';
import 'package:dristi_open_source/core/global_providers/favourites_items/favourites_items_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favouriteItemsProvider =
    NotifierProvider<FavouritesItemsNotifier, FavouritesItemsState>(
      FavouritesItemsNotifier.new,
      name: 'favouriteItemsProvider',
    );
