import 'package:dristi_open_source/data/data_sources/on_boarding_data_source.dart';
import 'package:dristi_open_source/domain/entities/minimum_version_entity.dart';
import 'package:dristi_open_source/domain/repositories/on_boarding_repository.dart';

class OnBoardingRepositoryImp implements OnBoardingRepository {
  OnBoardingRepositoryImp({required this.dataSource});

  final OnBoardingDataSource dataSource;

  @override
  Future<void> setFirstTimeStatusFalse() async {
    await dataSource.setFirstTimeStatusFalse();
  }

  @override
  Future<bool> getFirstTimeStatus() async {
    final response = dataSource.getFirstTimeStatus();

    return response;
  }

  @override
  Future<(String, dynamic)> buttonSubmit() async {
    final response = await dataSource.buttonSubmit();

    return Future.value((response.statusMessage!, true));
  }

  @override
  Future<MinimumVersionEntity> fetchMinimumVersionRequired() async {
    final response = await dataSource.fetchMinimumVersionRequired();

    return response.minimumVersionResponse;
  }
}
