import 'package:dristi_open_source/domain/entities/settings_entity.dart';
import 'package:equatable/equatable.dart';

enum SettingsStatus { initial, loading, success, failure }

class SettingsState<T> extends Equatable {
  const SettingsState({
    this.status = SettingsStatus.initial,
    this.data,
    this.errorMessage,
  });

  final SettingsStatus status;
  final SettingsEntity? data;
  final String? errorMessage;

  SettingsState copyWith({
    SettingsStatus? status,
    SettingsEntity? data,
    String? errorMessage,
  }) {
    return SettingsState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, data, errorMessage];
}
