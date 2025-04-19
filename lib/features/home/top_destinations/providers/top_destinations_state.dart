import 'package:dristi_open_source/domain/entities/destinations_list_entity.dart';
import 'package:equatable/equatable.dart';

enum TopDestinationsStatus { initial, loading, success, failure }

class TopDestinationsState<T> extends Equatable {
  const TopDestinationsState({
    this.status = TopDestinationsStatus.initial,
    this.data,
    this.errorMessage,
  });

  final TopDestinationsStatus status;
  final List<DestinationsListEntity>? data;
  final String? errorMessage;

  TopDestinationsState copyWith({
    TopDestinationsStatus? status,
    List<DestinationsListEntity>? data,
    String? errorMessage,
  }) {
    return TopDestinationsState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, data, errorMessage];
}
