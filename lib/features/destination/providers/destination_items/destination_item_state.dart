import 'package:equatable/equatable.dart';

enum DestinationItemsStatus { initial, loading, success, failure }

class DestinationItemsState<T> extends Equatable {
  const DestinationItemsState({
    this.status = DestinationItemsStatus.initial,
    this.data,
    this.errorMessage,
  });

  final DestinationItemsStatus status;
  final T? data;
  final String? errorMessage;

  DestinationItemsState copyWith({
    DestinationItemsStatus? status,
    T? data,
    String? errorMessage,
  }) {
    return DestinationItemsState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, data, errorMessage];
}
