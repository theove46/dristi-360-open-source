import 'package:dristi_open_source/domain/entities/district_entity.dart';
import 'package:dristi_open_source/features/districts/providers/district_notifier.dart';
import 'package:dristi_open_source/features/districts/providers/district_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final districtProvider = NotifierProvider<DistrictNotifier, DistrictState>(
  DistrictNotifier.new,
  name: 'districtProvider',
);

final districtsSearchField = StateProvider<String>(
  (ref) => '',
  name: 'districtsSearchField',
);

final filteredDistrictsProvider = StateProvider<List<DistrictEntity>>((ref) {
  final searchQuery = ref.watch(districtsSearchField).toLowerCase();
  final districtState = ref.watch(districtProvider);

  final allDistricts = districtState.data ?? [];

  return allDistricts.where((district) {
    final title = district.title.toLowerCase();
    final division = district.division.toLowerCase();
    return title.contains(searchQuery) || division.contains(searchQuery);
  }).toList();
}, name: 'filteredDistrictsProvider');
