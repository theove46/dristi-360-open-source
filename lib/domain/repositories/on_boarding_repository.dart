import 'package:dristi_open_source/data/data_sources/on_boarding_data_source.dart';
import 'package:dristi_open_source/data/repositories_impl/on_boarding_repository_impl.dart';
import 'package:dristi_open_source/domain/entities/minimum_version_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final onBoardingRepositoryProvider = Provider<OnBoardingRepository>((ref) {
  final dataSource = ref.read(onBoardingDataSourceProvider);
  return OnBoardingRepositoryImp(dataSource: dataSource);
});

abstract class OnBoardingRepository {
  Future<void> setFirstTimeStatusFalse();

  Future<bool> getFirstTimeStatus();

  Future<(String, dynamic)> buttonSubmit();

  Future<MinimumVersionEntity> fetchMinimumVersionRequired();
}
