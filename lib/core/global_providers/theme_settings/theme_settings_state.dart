import 'package:dristi_open_source/core/enums/app_theme.dart';
import 'package:equatable/equatable.dart';

class ThemeState extends Equatable {
  const ThemeState({this.data = AppTheme.systemDefault});

  final AppTheme data;

  ThemeState copyWith({AppTheme? data}) {
    return ThemeState(data: data ?? this.data);
  }

  @override
  List<Object?> get props => [data];
}
