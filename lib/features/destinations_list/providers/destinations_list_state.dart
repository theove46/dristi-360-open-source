import 'package:dristi_open_source/domain/entities/destinations_list_entity.dart';
import 'package:equatable/equatable.dart';

enum DestinationListStatus { initial, loading, success, failure }

class DestinationsListState<T> extends Equatable {
  const DestinationsListState({
    this.status = DestinationListStatus.initial,
    this.data,
    this.errorMessage,
  });

  final DestinationListStatus status;
  final List<DestinationsListEntity>? data;
  final String? errorMessage;

  DestinationsListState copyWith({
    DestinationListStatus? status,
    List<DestinationsListEntity>? data,
    String? errorMessage,
  }) {
    return DestinationsListState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, data, errorMessage];
}
