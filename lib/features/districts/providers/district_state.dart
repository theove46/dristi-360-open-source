import 'package:dristi_open_source/domain/entities/district_entity.dart';
import 'package:equatable/equatable.dart';

enum DistrictStatus { initial, loading, success, failure }

class DistrictState<T> extends Equatable {
  const DistrictState({
    this.status = DistrictStatus.initial,
    this.data,
    this.errorMessage,
  });

  final DistrictStatus status;
  final List<DistrictEntity>? data;
  final String? errorMessage;

  DistrictState copyWith({
    DistrictStatus? status,
    List<DistrictEntity>? data,
    String? errorMessage,
  }) {
    return DistrictState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, data, errorMessage];
}
