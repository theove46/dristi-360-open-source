import 'package:dristi_open_source/data/data_sources/destinations_list_data_source.dart';
import 'package:dristi_open_source/domain/entities/destinations_list_entity.dart';
import 'package:dristi_open_source/domain/repositories/destinations_list_repositories.dart';

class DestinationsListRepositoryImp implements DestinationsListRepository {
  const DestinationsListRepositoryImp({required this.dataSource});

  final DestinationsListDataSource dataSource;

  @override
  Future<List<DestinationsListEntity>> getDestinationsListComponents({
    required String appLanguage,
    required bool isRefresh,
  }) async {
    final response = await dataSource.getDestinationsListComponents(
      appLanguage: appLanguage,
      isRefresh: isRefresh,
    );

    return response.destinationsListItems;
  }
}
