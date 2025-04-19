import 'package:dristi_open_source/data/repositories_impl/favorite_items_repositories_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/local_data_sources/cache_service.dart';

final favoriteItemsRepositoryProvider = Provider<FavoriteItemsRepository>((
  ref,
) {
  final cacheService = ref.read(cacheServiceProvider);

  return FavoriteItemsRepositoryImp(cacheService: cacheService);
});

abstract class FavoriteItemsRepository {
  Future<void> setFavouritesItemsList(Set<String> favoritesList);

  Future<Set<String>> getFavouritesItemsList();
}
