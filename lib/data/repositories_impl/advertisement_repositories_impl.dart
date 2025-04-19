import 'package:dristi_open_source/data/data_sources/advertisement_data_source.dart';
import 'package:dristi_open_source/domain/entities/advertisement_entity.dart';
import 'package:dristi_open_source/domain/repositories/advertisement_repositories.dart';

class AdvertisementRepositoryImp implements AdvertisementRepository {
  const AdvertisementRepositoryImp({required this.dataSource});

  final AdvertisementDataSource dataSource;

  @override
  Future<AdvertisementEntity> getSingleAdvertisementComponents() async {
    final response = await dataSource.getSingleAdvertisementComponents();

    return response.singleAdvertisementItem;
  }

  @override
  Future<List<AdvertisementEntity>> getMultipleAdvertisementComponents() async {
    final response = await dataSource.getMultipleAdvertisementComponents();

    return response.multipleAdvertisementItems;
  }
}
