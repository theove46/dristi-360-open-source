import 'package:dristi_open_source/data/data_sources/accommodation_data_source.dart';
import 'package:dristi_open_source/domain/entities/accommodation_entity.dart';
import 'package:dristi_open_source/domain/repositories/accommodation_repositories.dart';

class AccommodationRepositoryImp implements AccommodationRepository {
  const AccommodationRepositoryImp({required this.dataSource});

  final AccommodationDataSource dataSource;

  @override
  Future<AccommodationEntity> getAccommodationData(
    String appLanguage,
    String id,
  ) async {
    final response = await dataSource.getAccommodationData(appLanguage, id);

    return response.response;
  }
}
