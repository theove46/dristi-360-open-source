import 'package:dristi_open_source/domain/entities/categories_entity.dart';
import 'package:equatable/equatable.dart';

enum CategoriesStatus { initial, loading, success, failure }

class CategoriesState<T> extends Equatable {
  const CategoriesState({
    this.status = CategoriesStatus.initial,
    this.data,
    this.errorMessage,
  });

  final CategoriesStatus status;
  final List<CategoryEntity>? data;
  final String? errorMessage;

  CategoriesState copyWith({
    CategoriesStatus? status,
    List<CategoryEntity>? data,
    String? errorMessage,
  }) {
    return CategoriesState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, data, errorMessage];
}
