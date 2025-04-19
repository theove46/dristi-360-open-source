import 'package:equatable/equatable.dart';
import 'package:package_info_plus/package_info_plus.dart';

enum PackageInfoStatus { initial, loading, success, failure }

class PackageInfoState extends Equatable {
  const PackageInfoState({
    this.data,
    this.status = PackageInfoStatus.initial,
  });

  final PackageInfo? data;
  final PackageInfoStatus status;

  PackageInfoState copyWith({
    PackageInfo? data,
    PackageInfoStatus? status,
  }) {
    return PackageInfoState(
      data: data ?? this.data,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [data, status];
}
