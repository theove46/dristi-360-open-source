import 'package:dristi_open_source/domain/entities/destinations_list_entity.dart';
import 'package:dristi_open_source/data/data_sources/slider_data_source.dart';
import 'package:dristi_open_source/domain/repositories/slider_repositories.dart';

class SliderRepositoryImp implements SliderRepository {
  const SliderRepositoryImp({required this.dataSource});

  final SliderDataSource dataSource;

  @override
  Future<List<DestinationsListEntity>> getSliderComponents({
    required String appLanguage,
    required bool isRefresh,
  }) async {
    final response = await dataSource.sliderComponents(
      appLanguage: appLanguage,
      isRefresh: isRefresh,
    );

    return response.destinationsListItems;
  }
}
