import 'package:dristi_open_source/core/loggers/logger.dart';
import 'package:dristi_open_source/domain/repositories/categories_repositories.dart';
import 'package:dristi_open_source/features/home/categories/providers/categories_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesNotifier extends Notifier<CategoriesState> {
  late CategoriesRepository repository;

  @override
  CategoriesState build() {
    repository = ref.read(categoriesRepositoryProvider);
    return const CategoriesState();
  }

  Future<void> getCategoriesComponents({
    required String appLanguage,
    required bool isRefresh,
  }) async {
    try {
      state = state.copyWith(status: CategoriesStatus.loading);

      final response = await repository.getCategoriesComponents(
        appLanguage: appLanguage,
        isRefresh: isRefresh,
      );

      if (response.isNotEmpty) {
        state = state.copyWith(
          data: response,
          status: CategoriesStatus.success,
        );
      } else {
        state = state.copyWith(status: CategoriesStatus.failure);
      }
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());

      state = state.copyWith(status: CategoriesStatus.failure);
    }
  }
}
