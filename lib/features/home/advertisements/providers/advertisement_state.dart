import 'package:equatable/equatable.dart';

enum AdvertisementStatus { initial, loading, success, failure }

class AdvertisementState<T> extends Equatable {
  const AdvertisementState({
    this.status = AdvertisementStatus.initial,
    this.data,
    this.errorMessage,
  });

  final AdvertisementStatus status;
  final T? data;
  final String? errorMessage;

  AdvertisementState copyWith({
    AdvertisementStatus? status,
    T? data,
    String? errorMessage,
  }) {
    return AdvertisementState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, data, errorMessage];
}
