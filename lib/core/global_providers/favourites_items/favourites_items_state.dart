import 'package:equatable/equatable.dart';

enum FavouritesItemsStatus { initial, loading, success, failure }

class FavouritesItemsState<T> extends Equatable {
  const FavouritesItemsState({
    this.status = FavouritesItemsStatus.initial,
    this.data = const {},
    this.errorMessage,
  });

  final FavouritesItemsStatus status;
  final Set<String> data;
  final String? errorMessage;

  FavouritesItemsState copyWith({
    FavouritesItemsStatus? status,
    Set<String>? data,
    String? errorMessage,
  }) {
    return FavouritesItemsState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, data, errorMessage];
}
