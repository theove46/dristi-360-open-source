import 'package:flutter_riverpod/flutter_riverpod.dart';

final spotsListSearchField = StateProvider.autoDispose<String>(
  (ref) => '',
  name: 'spotsListSearchField',
);

final spotsListCategoryField = StateProvider.autoDispose<String>(
  (ref) => '',
  name: 'spotsListCategoryField',
);

final spotsListDistrictField = StateProvider.autoDispose<String>(
  (ref) => '',
  name: 'spotsListDistrictField',
);

final spotsListIsShowFavourite = StateProvider.autoDispose<bool>(
  (ref) => false,
  name: 'spotsListIsShowFavourite',
);
