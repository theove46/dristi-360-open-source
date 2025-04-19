import 'package:dristi_open_source/core/global_providers/favourites_items/favourites_items_state.dart';
import 'package:dristi_open_source/domain/repositories/favorite_items_repositories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavouritesItemsNotifier extends Notifier<FavouritesItemsState> {
  late FavoriteItemsRepository repository;

  @override
  FavouritesItemsState build() {
    repository = ref.read(favoriteItemsRepositoryProvider);
    return const FavouritesItemsState();
  }

  void loadSavedItems() async {
    final favouritesList = await repository.getFavouritesItemsList();

    state = state.copyWith(data: favouritesList);
  }

  void toggleFavouritesItems(String id) async {
    if (state.data.contains(id)) {
      state = state.copyWith(data: {...state.data}..remove(id));
    } else {
      state = state.copyWith(data: {...state.data}..add(id));
    }

    await repository.setFavouritesItemsList(state.data);
  }

  bool isSaved(int id) {
    return state.data.contains(id.toString());
  }
}
