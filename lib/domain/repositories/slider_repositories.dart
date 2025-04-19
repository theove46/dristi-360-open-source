import 'package:dristi_open_source/domain/entities/destinations_list_entity.dart';
import 'package:dristi_open_source/data/data_sources/slider_data_source.dart';
import 'package:dristi_open_source/data/repositories_impl/slider_repositories_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sliderRepositoryProvider = Provider<SliderRepository>((ref) {
  final dataSource = ref.read(sliderDataSourceProvider);
  return SliderRepositoryImp(dataSource: dataSource);
});

abstract class SliderRepository {
  Future<List<DestinationsListEntity>> getSliderComponents({
    required String appLanguage,
    required bool isRefresh,
  });
}
