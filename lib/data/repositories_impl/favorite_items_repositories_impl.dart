import 'package:dristi_open_source/domain/repositories/favorite_items_repositories.dart';
import 'package:dristi_open_source/data/local_data_sources/cache_service.dart';

class FavoriteItemsRepositoryImp implements FavoriteItemsRepository {
  const FavoriteItemsRepositoryImp({required this.cacheService});

  final CacheService cacheService;

  @override
  Future<void> setFavouritesItemsList(Set<String> favoritesList) async {
    await cacheService.setFavouritesItemsList(favoritesList);
  }

  @override
  Future<Set<String>> getFavouritesItemsList() async {
    final favouritesList = await cacheService.getFavouritesItemsList();

    return favouritesList;
  }
}
