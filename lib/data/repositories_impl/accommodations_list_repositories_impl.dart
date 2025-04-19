import 'package:dristi_open_source/data/data_sources/accommodations_list_data_source.dart';
import 'package:dristi_open_source/domain/entities/accommodations_list_entity.dart';
import 'package:dristi_open_source/domain/repositories/accommodations_list_repositories.dart';

class AccommodationsListRepositoryImp implements AccommodationsListRepository {
  const AccommodationsListRepositoryImp({required this.dataSource});

  final AccommodationsListDataSource dataSource;

  @override
  Future<List<AccommodationsListEntity>> getAccommodationsListComponents({
    required String appLanguage,
    required bool isRefresh,
  }) async {
    final response = await dataSource.getAccommodationsListComponents(
      appLanguage: appLanguage,
      isRefresh: isRefresh,
    );

    return response.response;
  }
}
