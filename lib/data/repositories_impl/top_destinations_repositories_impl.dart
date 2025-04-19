import 'package:dristi_open_source/domain/entities/destinations_list_entity.dart';
import 'package:dristi_open_source/data/data_sources/top_destinations_data_source.dart';
import 'package:dristi_open_source/domain/repositories/top_destinations_repositories.dart';

class TopDestinationsRepositoryImp implements TopDestinationsRepository {
  const TopDestinationsRepositoryImp({required this.dataSource});

  final TopDestinationsDataSource dataSource;

  @override
  Future<List<DestinationsListEntity>> getTopDestinationsComponents({
    required String appLanguage,
    required bool isRefresh,
  }) async {
    final response = await dataSource.getTopDestinationsComponents(
      appLanguage: appLanguage,
      isRefresh: isRefresh,
    );

    return response.destinationsListItems;
  }
}
