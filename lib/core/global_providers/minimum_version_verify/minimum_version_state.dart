import 'package:dristi_open_source/domain/entities/minimum_version_entity.dart';
import 'package:equatable/equatable.dart';

enum MinimumVersionStatus { initial, loading, success, failure }

class MinimumVersionState extends Equatable {
  const MinimumVersionState({
    this.data,
    this.status = MinimumVersionStatus.initial,
  });

  final MinimumVersionEntity? data;
  final MinimumVersionStatus status;

  MinimumVersionState copyWith({
    MinimumVersionEntity? data,
    MinimumVersionStatus? status,
  }) {
    return MinimumVersionState(
      data: data ?? this.data,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [data, status];
}
