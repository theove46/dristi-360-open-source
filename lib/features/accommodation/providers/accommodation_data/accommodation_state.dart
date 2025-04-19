import 'package:dristi_open_source/domain/entities/accommodation_entity.dart';
import 'package:equatable/equatable.dart';

enum AccommodationStatus { initial, loading, success, failure }

class AccommodationState<T> extends Equatable {
  const AccommodationState({
    this.status = AccommodationStatus.initial,
    this.data,
    this.errorMessage,
  });

  final AccommodationStatus status;
  final AccommodationEntity? data;
  final String? errorMessage;

  AccommodationState copyWith({
    AccommodationStatus? status,
    AccommodationEntity? data,
    String? errorMessage,
  }) {
    return AccommodationState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, data, errorMessage];
}
