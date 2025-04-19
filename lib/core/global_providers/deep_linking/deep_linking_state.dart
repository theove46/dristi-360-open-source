import 'package:equatable/equatable.dart';

enum DeepLinkingStatus { initial, loading, success, failure }

class DeepLinkingState<T> extends Equatable {
  const DeepLinkingState({
    this.status = DeepLinkingStatus.initial,
    this.data,
    this.errorMessage,
  });

  final DeepLinkingStatus status;
  final T? data;
  final String? errorMessage;

  DeepLinkingState copyWith({
    DeepLinkingStatus? status,
    T? data,
    String? errorMessage,
  }) {
    return DeepLinkingState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        data,
        errorMessage,
      ];
}
