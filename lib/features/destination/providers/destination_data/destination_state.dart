import 'package:dristi_open_source/domain/entities/destination_entity.dart';
import 'package:equatable/equatable.dart';

enum DestinationStatus { initial, loading, success, failure }

class DestinationState<T> extends Equatable {
  const DestinationState({
    this.status = DestinationStatus.initial,
    this.data,
    this.errorMessage,
  });

  final DestinationStatus status;
  final DestinationEntity? data;
  final String? errorMessage;

  DestinationState copyWith({
    DestinationStatus? status,
    DestinationEntity? data,
    String? errorMessage,
  }) {
    return DestinationState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, data, errorMessage];
}
