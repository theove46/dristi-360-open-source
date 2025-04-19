import 'package:equatable/equatable.dart';

enum OnBoardingStatus { initial, loading, success, failure }

class OnBoardingState<T> extends Equatable {
  const OnBoardingState({
    this.status = OnBoardingStatus.initial,
    this.data,
    this.errorMessage,
  });

  final OnBoardingStatus status;
  final T? data;
  final String? errorMessage;

  OnBoardingState copyWith({
    OnBoardingStatus? status,
    T? data,
    String? errorMessage,
  }) {
    return OnBoardingState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, data, errorMessage];
}
