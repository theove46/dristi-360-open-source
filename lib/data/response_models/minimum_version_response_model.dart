import 'package:dristi_open_source/domain/entities/minimum_version_entity.dart';

class MinimumVersionResponseModel {
  MinimumVersionResponseModel(this.minimumVersionResponse);

  MinimumVersionResponseModel.fromJson({required dynamic json}) {
    minimumVersionResponse = MinimumVersionData.fromJson(json);
  }

  MinimumVersionEntity minimumVersionResponse = MinimumVersionEntity.initial();
}

class MinimumVersionData extends MinimumVersionEntity {
  String? minimumVersion;

  MinimumVersionData({this.minimumVersion})
    : super(minVersion: minimumVersion ?? "");

  factory MinimumVersionData.fromJson(dynamic json) {
    return MinimumVersionData(minimumVersion: json['min_version']);
  }
}
