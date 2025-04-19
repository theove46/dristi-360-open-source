import 'package:dristi_open_source/core/enums/bottom_nav_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bottomNavBarProvider = StateProvider<BottomNavItems>(
  (ref) => BottomNavItems.home,
  name: 'bottomNavBarProvider',
);
